import { Box, Center, Loader } from "@mantine/core";
import { useEffect, useMemo, useState } from "react";

const TweetEmbedded = ({ tweetId, onShow, onFailed }: {
  tweetId: string;
  onShow?: () => void;
  onFailed?: () => void;
}) => {
  const [tweetHeight, setTweetHeight] = useState(0);
  const [noTweet, setNoTweet] = useState(false);
  const widgetId = tweetId;
  const embedded = useMemo(() => (
    <Box
      component="iframe"
      style={{ border: "none" }}
      id={widgetId}
      allowTransparency={true}
      allowFullScreen={true}
      maw={550}
      height={tweetHeight}
      display="block"
      pos="static"
      title="Twitter Tweet"
      src={`https://platform.twitter.com/embed/Tweet.html?embedId=${widgetId}&frame=false&hideCard=false&hideThread=false&id=${tweetId}&lang=en&origin=https%3A%2F%2Fpublish.twitter.com%2F%23&theme=light`}
    />
  ), [tweetHeight]);
  useEffect(() => {
    setNoTweet(false);
    setTweetHeight(0);
  }, [tweetId]);
  useEffect(() => {
    if (typeof window === undefined) return;
    const receiveTweetResizeListener = (message: MessageEvent) => {
      if (noTweet) return;
      if (message.origin !== "https://platform.twitter.com") return;
      const embed = message.data?.["twttr.embed"];
      if (!embed) return;
      if (embed.method === "twttr.private.no_results") {
        onFailed?.();
        setNoTweet(true);
        return;
      }
      if (embed.method !== "twttr.private.resize") return;
      if (embed.id !== widgetId) return;
      const height = embed.params[0]?.height;
      if (height) {
        if (!tweetHeight) onShow?.();
        setTweetHeight(height);
      }
    };
    window.addEventListener("message", receiveTweetResizeListener);
    return () => window.addEventListener("message", receiveTweetResizeListener);
  });
  return (
    <>
      {embedded}
      {!tweetHeight && (
        <>
          {noTweet ? "Tweet has been deleted" : (
            <Center>
              <Loader />
            </Center>
          )}
        </>
      )}
    </>
  );
};

export default TweetEmbedded;
