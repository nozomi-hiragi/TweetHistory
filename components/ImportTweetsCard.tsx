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
import { modifyTweet } from "../models/ModifiedTweet";
import { Tweets } from "../models/Tweets";

const sliceArray = <T,>(arr: T[], size: number) =>
  arr.flatMap((_, i, a) => i % size ? [] : [a.slice(i, i + size)]);

const ProgressPercent = ({ value }: { value: number }) => (
  <Progress.Root size="xl">
    <Progress.Section value={value} animated>
      <Progress.Label>{Math.round(value)}%</Progress.Label>
    </Progress.Section>
  </Progress.Root>
);

const ImportTweetsCard = (props: MantineStyleProps) => {
  const [loading, setLoading] = useState(false);
  const [allCnt, setAllCnt] = useState(0);
  const [doneCnt, setDoneCnt] = useState(0);
  const [inputError, setInputError] = useState("");

  return (
    <Paper shadow="xs" p="sm" {...props}>
      <Title>Import tweets file</Title>
      <Text>file &quot;tweets.js&quot; from data folder</Text>

      {loading
        ? <ProgressPercent value={(doneCnt / allCnt) * 100} />
        : (
          <FileInput
            label="Input file"
            description="Chose tweets.js file"
            error={inputError}
            accept="text/javascript"
            onChange={(file) => {
              if (!file) return;

              if (file.name !== "tweets.js") {
                setInputError(`File name is not "tweets.js"`);
                return;
              } else setInputError("");

              setLoading(true);
              const reader = new FileReader();
              reader.onload = async (e) => {
                const text = e.target?.result;
                if (typeof text !== "string") {
                  return;
                }

                const json = JSON.parse(
                  text.substring(text.indexOf("[")),
                ) as Tweets;
                setAllCnt(json.length);

                const sliced = sliceArray(json, 100);
                for (const bat of sliced) {
                  await Promise.all(
                    bat.map(async ({ tweet }) =>
                      db.tweets.put(modifyTweet(tweet))
                    ),
                  );
                  setDoneCnt((p) => p + bat.length);
                }
                setLoading(false);
              };
              reader.readAsText(file);
            }}
          />
        )}
      {doneCnt !== 0 && doneCnt === allCnt &&
        <p>Finish {doneCnt} tweets</p>}
    </Paper>
  );
};

export default ImportTweetsCard;
