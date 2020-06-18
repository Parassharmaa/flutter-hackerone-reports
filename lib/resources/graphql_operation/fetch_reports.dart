final String fetchReportsQuery = r"""
  query HacktivityPageQuery(
    $querystring: String
    $orderBy: HacktivityItemOrderInput
    $secureOrderBy: FiltersHacktivityItemFilterOrder
    $where: FiltersHacktivityItemFilterInput
    $count: Int
    $cursor: String
  ) {
    hacktivity_items(
      first: $count
      after: $cursor
      query: $querystring
      order_by: $orderBy
      secure_order_by: $secureOrderBy
      where: $where
    ) {
      total_count
      ...HacktivityList
    }
  }
  fragment HacktivityList on HacktivityItemConnection {
    total_count
    pageInfo {
      endCursor
      hasNextPage
    }
    edges {
      node {
        ... on HacktivityItemInterface {
          id
          databaseId: _id
          ...HacktivityItem
        }
      }
    }
  }
  fragment HacktivityItem on HacktivityItemUnion {
    type: __typename
    ... on HacktivityItemInterface {
      id
      votes {
        total_count
      }
    }
    ... on Undisclosed {
      id
      ...HacktivityItemUndisclosed
    }
    ... on Disclosed {
      id
      ...HacktivityItemDisclosed
    }
    ... on HackerPublished {
      id
      ...HacktivityItemHackerPublished
    }
  }
  fragment HacktivityItemUndisclosed on Undisclosed {
    id
    reporter {
      id
      username
      ...UserLinkWithMiniProfile
    }
    team {
      handle
      name
      medium_profile_picture: profile_picture(size: medium)
      url
      id
      ...TeamLinkWithMiniProfile
    }
    latest_disclosable_action
    latest_disclosable_activity_at
    requires_view_privilege
    total_awarded_amount
    currency
  }
  fragment TeamLinkWithMiniProfile on Team {
    id
    handle
    name
  }
  fragment UserLinkWithMiniProfile on User {
    id
    username
  }
  fragment HacktivityItemDisclosed on Disclosed {
    id
    reporter {
      id
      username
      ...UserLinkWithMiniProfile
    }
    team {
      handle
      name
      medium_profile_picture: profile_picture(size: medium)
      url
      id
      ...TeamLinkWithMiniProfile
    }
    report {
      id
      title
      substate
      url
    }
    latest_disclosable_action
    latest_disclosable_activity_at
    total_awarded_amount
    severity_rating
    currency
  }
  fragment HacktivityItemHackerPublished on HackerPublished {
    id
    reporter {
      id
      username
      ...UserLinkWithMiniProfile
    }
    team {
      id
      handle
      name
      medium_profile_picture: profile_picture(size: medium)
      url
      ...TeamLinkWithMiniProfile
    }
    report {
      id
      url
      title
      substate
    }
    latest_disclosable_activity_at
    severity_rating
  }
""";
