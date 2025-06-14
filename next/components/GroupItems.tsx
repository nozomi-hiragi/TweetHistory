import { useState } from "react";
import {
  ActionIcon,
  Button,
  Card,
  Checkbox,
  Group,
  Loader,
  Stack,
  TextInput,
  Title,
} from "@mantine/core";
import { useForm } from "@mantine/form";
import { useLiveQuery } from "dexie-react-hooks";
import { db } from "../db";
import { TweetGroup } from "../models/TweetGroup";

const GroupCard = ({ group }: { group: TweetGroup }) => {
  const [safety, setSafety] = useState(true);
  const deleteGroup = () => db.groups.delete(group.id!);
  return (
    <Card key={group.id} shadow="xs">
      <Stack>
        <Group>
          <Title order={4}>{group.name}</Title>
          <Checkbox
            label="Delete"
            onChange={(e) => setSafety(!e.currentTarget.checked)}
          />
          <ActionIcon disabled={safety} color="red" onClick={deleteGroup}>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              className="icon icon-tabler icon-tabler-trash-filled"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="#2c3e50"
              fill="none"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path stroke="none" d="M0 0h24v24H0z" fill="none" />
              <path
                d="M20 6a1 1 0 0 1 .117 1.993l-.117 .007h-.081l-.919 11a3 3 0 0 1 -2.824 2.995l-.176 .005h-8c-1.598 0 -2.904 -1.249 -2.992 -2.75l-.005 -.167l-.923 -11.083h-.08a1 1 0 0 1 -.117 -1.993l.117 -.007h16z"
                stroke-width="0"
                fill="currentColor"
              />
              <path
                d="M14 2a2 2 0 0 1 2 2a1 1 0 0 1 -1.993 .117l-.007 -.117h-4l-.007 .117a1 1 0 0 1 -1.993 -.117a2 2 0 0 1 1.85 -1.995l.15 -.005h4z"
                stroke-width="0"
                fill="currentColor"
              />
            </svg>
          </ActionIcon>
        </Group>
        {group.ids.length} tweets
      </Stack>
    </Card>
  );
};

const GroupItems = (
  props: { onChangeGroups?: (groups: TweetGroup[]) => void },
) => {
  const groups = useLiveQuery(() =>
    db.groups
      .toArray()
      .then((v) => {
        props.onChangeGroups?.(v);
        return v;
      })
  );
  const groupFrom = useForm({
    initialValues: { groupName: "" },
    validate: {
      groupName: (
        value,
      ) => (/[^<>#"%{}|\\/^[\]`:?@+=,*'&$!]*/.test(value)
        ? null
        : "Using unable character"),
    },
  });

  return (
    <Stack>
      <Title order={2}>Groups</Title>
      {groups
        ? (
          <Group>
            {groups.map((v) => <GroupCard key={v.id} group={v} />)}
            <Card
              shadow="xs"
              component="form"
              onSubmit={groupFrom.onSubmit(({ groupName }) => {
                if (!groups) {
                  groupFrom.setErrors({ groupName: "DB is not ready maybe" });
                  return;
                }
                const regExistName = new RegExp(`^${groupName}(\\d*)$`);
                const index = groups
                  .filter((s) => regExistName.test(s.name))
                  .map((s) => Number(s.name.match(regExistName)![1] || 0))
                  .sort((a, b) => b - a)[0];
                db.groups.add({
                  name: `${groupName}${index !== undefined ? index + 1 : ""}`,
                  ids: [],
                }).then(() => {
                  groupFrom.reset();
                });
              })}
            >
              <Stack justify="center" gap="xs">
                <Title order={3}>Create new Group</Title>
                <TextInput
                  label="Name"
                  {...groupFrom.getInputProps("groupName")}
                />
                <Button type="submit">Create</Button>
              </Stack>
            </Card>
          </Group>
        )
        : <Loader />}
    </Stack>
  );
};

export default GroupItems;
