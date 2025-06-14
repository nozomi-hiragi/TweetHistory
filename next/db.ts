import Dexie, { Table } from "dexie";
import { ModifiedTweet } from "./models/ModifiedTweet";
import { TweetGroup } from "./models/TweetGroup";

export class TweetDexie extends Dexie {
  tweets!: Table<ModifiedTweet>;
  groups!: Table<TweetGroup>;

  constructor() {
    super("TweetHistory");
    this.version(1).stores({
      tweets: "id, created_at, favorite_count, retweet_count",
      groups: "++id, &name, *ids",
    });
  }
}

export const db = new TweetDexie();
