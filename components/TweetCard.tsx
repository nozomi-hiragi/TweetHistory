import { useEffect, useMemo, useState } from "react";
import {
  Button,
  Card,
  Grid,
  Group,
  Image,
  Select,
  Stack,
  Text,
} from "@mantine/core";
import { db } from "../db";
import { ModifiedTweet } from "../models/ModifiedTweet";
import { TweetGroup } from "../models/TweetGroup";
import TweetEmbedded from "./TweetEmbedded";

const TweetCard = ({ tweet, groups }: {
  tweet: ModifiedTweet;
  groups: TweetGroup[];
}) => {
  const [show, setShow] = useState(false);
  const [belongGroup, setBelongGroup] = useState<TweetGroup | undefined>(
    groups.filter((v) => v.ids.includes(tweet.id))[0],
  );

  const tweetContent = useMemo(() => (
    <Stack gap="xs">
      <Group justify="space-between">
        <Text>Tweet ID: {tweet.id}</Text>
        <Text>{tweet.created_at.toLocaleString()}</Text>
      </Group>
      <Text>{tweet.text}</Text>
      {tweet.extended_entities?.media && (
        <Grid>
          {tweet.extended_entities.media.map((m) => {
            if (m.type === "photo") {
              const url = new URL(m.media_url_https);
              url.searchParams.set("name", "small");
              return (
                <Image
                  src={url.href}
                  fit={m.sizes.small.resize === "crop" ? "cover" : "contain"}
                  w={m.sizes.small.w}
                  h={m.sizes.small.h}
                />
              );
            }
          })}
        </Grid>
      )}
      <Group>
        <Text>{tweet.retweet_count}RT</Text>
        <Text>{tweet.favorite_count}Fav</Text>
      </Group>
    </Stack>
  ), [tweet]);

  const groupSelector = useMemo(() => (
    <Select
      label="Group"
      placeholder="Select Group"
      data={groups.map((v) => v.name)}
      value={belongGroup?.name || ""}
      onChange={(newGroupName) => {
        const updates: Promise<number>[] = [];

        const currentGroup = groups
          .find((v) => v.name === belongGroup?.name);
        if (currentGroup) {
          currentGroup.ids = currentGroup.ids.filter((v) => v !== tweet.id);
          updates.push(db.groups.update(currentGroup.id!, currentGroup));
        }

        const targetGroup = groups
          .find((v) => v.name === newGroupName);
        if (targetGroup) {
          targetGroup.ids.push(tweet.id);
          db.groups.update(targetGroup.id!, targetGroup);
        }

        Promise.all(updates).then(() => setBelongGroup(targetGroup));
      }}
    />
  ), [belongGroup, groups]);

  const embeddedTweet = useMemo(
    () => show ? <TweetEmbedded tweetId={tweet.id} /> : <></>,
    [show],
  );

  useEffect(() => {
    if (!belongGroup) return;
    if (groups.map((v) => v.name).includes(belongGroup.name)) return;
    setBelongGroup(undefined);
  }, [groups]);

  return (
    <Card shadow="sm" my="sm">
      {tweetContent}
      <Group align="end">
        {groupSelector}
        <Button onClick={() => setShow((p) => !p)}>
          {show ? "Hide" : "Show"}
        </Button>
      </Group>
      {embeddedTweet}
    </Card>
  );
};

export default TweetCard;
