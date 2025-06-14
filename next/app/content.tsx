"use client";
import "dayjs/locale/ja";
import { useEffect, useState } from "react";
import { Center, Container, Loader } from "@mantine/core";
import { db } from "../db";
import { TweetGroup } from "../models/TweetGroup";
import GroupItems from "../components/GroupItems";
import Tweets from "../components/Tweets";

export default function Content() {
  const [dbReady, setDbReady] = useState(false);
  const [groups, setGroups] = useState<TweetGroup[]>([]);

  useEffect(() => {
    db.open();
    db.on("ready", () => {
      setDbReady(true);
    });
  }, []);

  return (dbReady
    ? (
      <Container>
        <GroupItems onChangeGroups={setGroups} />
        <Tweets groups={groups} />
      </Container>
    )
    : (
      <Center>
        <Loader />
      </Center>
    ));
}
