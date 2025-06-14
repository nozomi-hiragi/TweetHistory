import { Metadata } from "next";
import { Box, Container, Stack, Text, Title } from "@mantine/core";
import Content from "./content";
import ImportTweetsCard from "../components/ImportTweetsCard";
import ExportButton from "../components/ExportButton";

export const metadata: Metadata = {};

export default function Home() {
  return (
    <Box component="main" bg="gray.0">
      <Container size="sm">
        <Stack gap="xs">
          <Box>
            <Title>Tweet History</Title>
            <Text>Tweet archive viewer</Text>
          </Box>
          <ImportTweetsCard my="sm" />
          <Box>
            <ExportButton />
          </Box>
          <Content />
        </Stack>
      </Container>
    </Box>
  );
}
