import { useEffect, useMemo, useState } from "react";
import {
  Button,
  Group,
  Loader,
  MultiSelect,
  NumberInput,
  Radio,
  Stack,
  Title,
} from "@mantine/core";
import { useForm } from "@mantine/form";
import { DatesProvider, DateTimePicker } from "@mantine/dates";
import { db } from "../db";
import { ModifiedTweet } from "../models/ModifiedTweet";
import TweetCard from "./TweetCard";
import { TweetGroup } from "../models/TweetGroup";

type TweetQueryParams = {
  group: string[];
  count: number;
  since: Date | null;
  until: Date | null;
  order: string;
};

const defaultTweetQuery: TweetQueryParams = {
  group: [],
  count: 20,
  since: null,
  until: null,
  order: "new",
};

const NOT_GROUPED = "Not grouped";

const Tweets = (
  { groups, whiteList }: { groups: TweetGroup[]; whiteList?: string[] },
) => {
  const [tweets, setTweets] = useState<ModifiedTweet[] | undefined>();
  const queryForm = useForm<TweetQueryParams>({
    initialValues: defaultTweetQuery,
  });

  const queryFormComponent = useMemo(
    () => (
      <form onSubmit={queryForm.onSubmit((v) => reloadTweets(v))}>
        <Group>
          <MultiSelect
            label="Group"
            placeholder="Chose Group"
            data={[...groups.map((v) => v.name), NOT_GROUPED]}
            {...queryForm.getInputProps("group")}
          />
          <NumberInput
            label="Count"
            w={100}
            min={1}
            max={100}
            {...queryForm.getInputProps("count")}
          />
          <DatesProvider settings={{ locale: "ja" }}>
            <DateTimePicker
              w={150}
              valueFormat="YYYY/M/D H:mm"
              label="Since"
              {...queryForm.getInputProps("since")}
            />
            <DateTimePicker
              w={150}
              valueFormat="YYYY/M/D H:mm"
              label="Until"
              {...queryForm.getInputProps("until")}
            />
          </DatesProvider>
          <Radio.Group
            defaultValue="new"
            {...queryForm.getInputProps("order")}
          >
            <Stack gap="xs">
              <Radio label="Newest" value="new" />
              <Radio label="Oldest" value="old" />
            </Stack>
          </Radio.Group>
          <Button type="submit">Reload</Button>
        </Group>
      </form>
    ),
    [queryForm],
  );

  const tweetsComponent = useMemo(() =>
    tweets
      ? tweets.map((v) => {
        return (
          <TweetCard
            key={v.id}
            tweet={v}
            groups={groups}
          />
        );
      })
      : <Loader />, [tweets, groups]);

  const reloadTweets = (
    { group, count, since, until, order }: TweetQueryParams,
  ) => {
    const groupNames = group.filter((v) => v !== NOT_GROUPED);
    const selectedNotGrouped = group.includes(NOT_GROUPED);

    let query = db.tweets.orderBy("created_at").filter((v) => {
      if (whiteList && whiteList.includes(v.id) === false) return false;

      if (since && v.created_at >= since === false) return false;
      if (until && v.created_at <= until === false) return false;

      if (group.length > 0) {
        const belongedGroup = groups.find((it) => it.ids.includes(v.id));
        if (belongedGroup) {
          if (!groupNames.includes(belongedGroup.name)) return false;
        } else if (!selectedNotGrouped) return false;
      }

      return true;
    });

    if (order === "new") query = query.reverse();

    query.limit(count).toArray().then(setTweets);
  };

  useEffect(() => {
    if (tweets === undefined) reloadTweets(defaultTweetQuery);
  }, []);

  return (
    <Stack>
      <Title order={2}>Tweets</Title>
      {queryFormComponent}
      {tweetsComponent}
    </Stack>
  );
};

export default Tweets;
