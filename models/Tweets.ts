export type EditInfo = {
  initial: {
    editTweetIds: string[];
    editableUntil: string;
    editsRemaining: string;
    isEditEligible: boolean;
  };
};

export type EntitySymbol = {
  text: string;
  indices: string[];
};

export type UserMention = {
  name: string;
  screen_name: string;
  indices: string[];
  id_str: string;
  id: string;
};

export type URLEntity = {
  url: string;
  expanded_url: string;
  display_url: string;
  indices: string[];
};

export type Entities = {
  hashtags: EntitySymbol[];
  symbols: EntitySymbol[];
  user_mentions: UserMention[];
  urls: URLEntity[];
  media?: Media[];
};

export type Size = {
  w: string;
  h: string;
  resize: string;
};

export type Sizes = {
  medium: Size;
  large: Size;
  thumb: Size;
  small: Size;
};

export type Media = {
  expanded_url: string;
  indices: string[];
  url: string;
  media_url: string;
  id_str: string;
  id: string;
  media_url_https: string;
  sizes: Sizes;
  type: string;
  display_url: string;
  source_status_id?: string;
  source_status_id_str?: string;
  source_user_id?: string;
  source_user_id_str?: string;
  video_info?: VideoInfo;
  additional_media_info?: any;
};

export type Variant = {
  url: string;
  content_type: string;
  bitrate?: string;
};

export type VideoInfo = {
  aspect_ratio: string[];
  duration_millis: string;
  variants: Variant[];
};

export type Geo = {
  type: string;
  coordinates: string[];
};

export type Tweet = {
  id: string;
  id_str: string;

  created_at: string;

  full_text: string;
  display_text_range: string[]; // 文字列の位置 簡単なのに変えよう
  source: string;

  retweet_count: string;
  favorite_count: string;

  retweeted: boolean;
  favorited: boolean;

  edit_info: EditInfo;
  truncated: boolean; // 省略された アーカイブではありえないよね

  entities: Entities;
  lang: string;

  in_reply_to_status_id_str?: string;
  in_reply_to_user_id?: string;
  in_reply_to_status_id?: string;
  in_reply_to_screen_name?: string;
  in_reply_to_user_id_str?: string;
  possibly_sensitive?: boolean;
  extended_entities?: { media: Media[] };
  withheld_in_countries?: string[];
  coordinates?: Geo;
  geo?: Geo;
};

export type Tweets = { tweet: Tweet }[];
