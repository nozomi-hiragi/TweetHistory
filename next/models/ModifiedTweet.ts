import {
  EditInfo,
  EntitySymbol,
  Geo,
  Media,
  Size,
  Sizes,
  Tweet,
  URLEntity,
  UserMention,
  Variant,
  VideoInfo,
} from "./Tweets";

export type ModifiedEditInfo = {
  initial: {
    editTweetIds: string[];
    editableUntil: string;
    editsRemaining: number;
    isEditEligible: boolean;
  };
};
export const modifyEditInfo = (target: EditInfo): ModifiedEditInfo => ({
  initial: {
    editTweetIds: target.initial.editTweetIds,
    editableUntil: target.initial.editableUntil,
    editsRemaining: Number(target.initial.editsRemaining),
    isEditEligible: target.initial.isEditEligible,
  },
});

export type ModifiedEntitySymbol = {
  text: string;
  indices: number[];
};
export const modifyEntitySymbol = (
  target: EntitySymbol,
): ModifiedEntitySymbol => ({
  text: target.text,
  indices: target.indices.map((v) => Number(v)),
});

export type ModifiedUserMention = {
  name: string;
  screen_name: string;
  indices: number[];
  id: string;
};
export const modifyUserMention = (
  target: UserMention,
): ModifiedUserMention => ({
  name: target.name,
  screen_name: target.screen_name,
  indices: target.indices.map((v) => Number(v)),
  id: target.id_str || target.id,
});

export type ModifiedURLEntity = {
  expanded_url: string;
  display_url: string;
  indices: number[];
};
export const modifyURLEntity = (target: URLEntity): ModifiedURLEntity => ({
  expanded_url: target.expanded_url,
  display_url: target.display_url,
  indices: target.indices.map((v) => Number(v)),
});

export type ModifiedSize = {
  w: number;
  h: number;
  resize: "fit" | "crop";
};
export const modifySize = (target: Size): ModifiedSize => ({
  w: Number(target.w),
  h: Number(target.h),
  resize: target.resize as "fit" | "crop",
});

export type ModifiedSizes = {
  thumb: ModifiedSize;
  small: ModifiedSize;
  medium: ModifiedSize;
  large: ModifiedSize;
};
export const modifySizes = (target: Sizes): ModifiedSizes => ({
  thumb: modifySize(target.thumb),
  small: modifySize(target.small),
  medium: modifySize(target.medium),
  large: modifySize(target.large),
});

export type ModifiedVariant = {
  url: string;
  content_type: "video/mp4" | "application/x-mpegURL";
  bitrate?: number;
};
export const modifyVariant = (target: Variant): ModifiedVariant => ({
  url: target.url,
  content_type: target.content_type as "video/mp4" | "application/x-mpegURL",
  bitrate: target.bitrate ? Number(target.bitrate) : undefined,
});

export type ModifiedVideoInfo = {
  aspect_ratio: number[];
  duration_millis: number;
  variants: ModifiedVariant[];
};
export const modifyVideoInfo = (target: VideoInfo): ModifiedVideoInfo => ({
  aspect_ratio: target.aspect_ratio.map((v) => Number(v)),
  duration_millis: Number(target.duration_millis),
  variants: target.variants.map((v) => modifyVariant(v)),
});

export type ModifiedMedia = {
  id: string;
  type: string;

  indices: number[];

  url: string;
  display_url: string;
  expanded_url: string;
  media_url_https: string;

  sizes: ModifiedSizes;

  source_status_id?: string;
  source_user_id?: string;

  video_info?: ModifiedVideoInfo;
};
export const modifyMedia = (target: Media): ModifiedMedia => ({
  id: target.id_str || target.id,
  type: target.type,
  indices: target.indices.map((v) => Number(v)),
  url: target.url,
  display_url: target.display_url,
  expanded_url: target.expanded_url,
  media_url_https: target.media_url_https || target.media_url,

  sizes: modifySizes(target.sizes),

  source_status_id: target.source_status_id_str || target.source_status_id,
  source_user_id: target.source_user_id_str || target.source_user_id,

  video_info: target.video_info
    ? modifyVideoInfo(target.video_info)
    : undefined,
});

export type ModifiedEntities = {
  hashtags: ModifiedEntitySymbol[];
  symbols: ModifiedEntitySymbol[];
  user_mentions: ModifiedUserMention[];
  urls: ModifiedURLEntity[];
  media?: ModifiedMedia[];
};

export type ModifiedGeo = {
  type: string;
  coordinates: number[];
};
export const ModifiedGeo = (target: Geo): ModifiedGeo => ({
  type: target.type,
  coordinates: target.coordinates.map((v) => Number(v)),
});

export type ModifiedTweet = {
  id: string;
  created_at: Date;
  text: string;
  display_text_range: number[];
  source: string;
  retweet_count: number;
  favorite_count: number;
  retweeted: boolean;
  favorited: boolean;
  edit_info: ModifiedEditInfo;
  lang: string;

  entities: ModifiedEntities;

  possibly_sensitive?: boolean;

  in_reply_to_status_id?: string;
  in_reply_to_user_id?: string;
  in_reply_to_screen_name?: string;

  extended_entities?: { media: ModifiedMedia[] };
  withheld_in_countries?: string[];
  coordinates?: ModifiedGeo;
  geo?: ModifiedGeo;
};
export const modifyTweet = (target: Tweet): ModifiedTweet => {
  return {
    id: target.id_str || target.id,
    created_at: new Date(target.created_at),
    text: target.full_text,
    display_text_range: target.display_text_range.map((v) => Number(v)),
    source: target.source,
    retweet_count: Number(target.retweet_count),
    favorite_count: Number(target.favorite_count),
    retweeted: target.retweeted,
    favorited: target.favorited,
    edit_info: modifyEditInfo(target.edit_info),
    lang: target.lang,
    entities: {
      hashtags: target.entities.hashtags.map((v) => modifyEntitySymbol(v)),
      symbols: target.entities.symbols.map((v) => modifyEntitySymbol(v)),
      user_mentions: target.entities.user_mentions
        .map((v) => modifyUserMention(v)),
      urls: target.entities.urls.map((v) => modifyURLEntity(v)),
      media: target.entities.media
        ? target.entities.media.map((v) => modifyMedia(v))
        : undefined,
    },

    possibly_sensitive: target.possibly_sensitive,
    in_reply_to_status_id: target.in_reply_to_status_id_str ||
      target.in_reply_to_status_id,
    in_reply_to_user_id: target.in_reply_to_user_id_str ||
      target.in_reply_to_user_id,
    in_reply_to_screen_name: target.in_reply_to_screen_name,
    extended_entities: target.extended_entities
      ? { media: (target.extended_entities.media.map((v) => modifyMedia(v))) }
      : undefined,
    withheld_in_countries: target.withheld_in_countries,
    coordinates: target.coordinates
      ? ModifiedGeo(target.coordinates)
      : undefined,
    geo: target.geo ? ModifiedGeo(target.geo) : undefined,
  };
};
