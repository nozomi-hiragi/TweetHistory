"use client";
import { useState } from "react";
import {
  FileInput,
  MantineStyleProps,
  Paper,
  Progress,
  Text,
  Title,
} from "@mantine/core";
import { db } from "../db";
import { ModifiedTweet, modifyTweet } from "../models/ModifiedTweet";
import { Tweets } from "../models/Tweets";
import { TweetGroup } from "../models/TweetGroup";

const sliceArray = <T,>(arr: T[], size: number) =>
  arr.flatMap((_, i, a) => i % size ? [] : [a.slice(i, i + size)]);

const ProgressPercent = ({ value }: { value: number }) => (
  <Progress.Root size="xl">
    <Progress.Section value={value} animated>
      <Progress.Label>{Math.round(value)}%</Progress.Label>
    </Progress.Section>
  </Progress.Root>
);

enum FileType {
  TWEET_JS,
  TWEET_HISTORY_JSON,
}

const importTweetsJs = async (
  text: string,
  onSetAllCount: (n: number) => void,
  onAppendDoneCnd: (n: number) => void,
) => {
  const json = JSON.parse(
    text.substring(text.indexOf("[")),
  ) as Tweets;
  onSetAllCount(json.length);

  const sliced = sliceArray(json, 100);
  for (const bat of sliced) {
    await Promise.all(
      bat.map(async ({ tweet }) =>
        db.tweets.put(modifyTweet(tweet))
      ),
    );
    onAppendDoneCnd(bat.length);
  }
}

const importTweetHistoryJson = async (
  text: string,
  onSetAllCount: (n: number) => void,
  onAppendDoneCnd: (n: number) => void,
) => {
  const { tweets, groups } = JSON.parse(text) as { tweets: ModifiedTweet[], groups: TweetGroup[] };
  onSetAllCount(tweets.length);

  onAppendDoneCnd(-1)
  await Promise.all([
    (async () => {
      const sliced = sliceArray(tweets, 100);
      for (const bat of sliced) {
        await Promise.all(bat.map(async (tweet) => {
          await db.tweets.put(tweet)
        }))
        onAppendDoneCnd(bat.length);
      }
    })(),
    (async () => {
      const sliced = sliceArray(groups, 100);
      for (const bat of sliced) {
        await Promise.all(bat.map(db.groups.put))
      }
    })(),
  ])
  onAppendDoneCnd(1)
}

const ImportTweetsCard = (props: MantineStyleProps) => {
  const [loading, setLoading] = useState(false);
  const [allCnt, setAllCnt] = useState(0);
  const [doneCnt, setDoneCnt] = useState(0);
  const [inputError, setInputError] = useState("");

  return (
    <Paper shadow="xs" p="sm" {...props}>
      <Title>Import tweets file</Title>
      <Text>file &quot;tweets.js&quot; from data folder or export file</Text>

      {loading
        ? <ProgressPercent value={(doneCnt / allCnt) * 100} />
        : (
          <FileInput
            label="Input file"
            description="Chose tweets.js or export file"
            error={inputError}
            accept="text/javascript,application/json"
            onChange={(file) => {
              if (!file) return;

              setInputError("")
              let fileType: FileType
              if (file.name === "tweets.js") {
                fileType = FileType.TWEET_JS
              } else if (/^tweet-history-\d+\.json$/.test(file.name)) {
                fileType = FileType.TWEET_HISTORY_JSON
              } else {
                setInputError(`File name is not supported: ${file.name}`)
                return
              }

              setLoading(true);
              const reader = new FileReader();
              reader.onload = async (e) => {
                const text = e.target?.result;
                if (typeof text !== "string") {
                  return;
                }

                switch (fileType) {
                  case FileType.TWEET_JS:
                    await importTweetsJs(text, setAllCnt, (n) => setDoneCnt((p) => p + n))
                    break;
                  case FileType.TWEET_HISTORY_JSON:
                    await importTweetHistoryJson(text, setAllCnt, (n) => setDoneCnt((p) => p + n))
                    break;
                }
                setLoading(false);
              };
              reader.readAsText(file);
            }}
          />
        )}
      {doneCnt !== 0 && doneCnt === allCnt &&
        <p>Finish {doneCnt} tweets</p>
      }
    </Paper>
  );
};

export default ImportTweetsCard;
