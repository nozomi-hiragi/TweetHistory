"use client";
import { useState } from "react";
import { Button, Group, Text } from "@mantine/core";
import { db } from "../db";

const padNum = (num: number, len = 2) => String(num).padStart(len, "0")

const dateToNumberString = (date: Date) => {
  return `${date.getFullYear()}${padNum(date.getMonth() + 1)}${padNum(date.getDate())}${padNum(date.getHours())}${padNum(date.getMinutes())}`
}

const ExportButton = () => {
  const [loader, setLoader] = useState(false)
  return (
    <Group>
      {loader ? <Text>Loading...</Text> : <Text fw={700} c="red" size="xl">
        期間があくとデータが消えるので、エクスポートして保護してください。
      </Text>}
      <Button
        disabled={loader}
        onClick={async () => {
          setLoader(true)
          const exportText = await Promise.all([
            db.tweets.orderBy("id").toArray(),
            db.groups.orderBy("id").toArray(),
          ]).then(([tweets, groups]) => ({ tweets, groups }))
            .then((exportObject) => JSON.stringify(exportObject))
          const blob = new Blob([exportText], { type: "application/json" });
          const link = document.createElement("a");
          link.href = URL.createObjectURL(blob);
          link.download = `tweet-history-${dateToNumberString(new Date())}.json`;
          link.click();
          setLoader(false)
        }}
      >
        Export
      </Button >
    </Group>
  );
};

export default ExportButton;
