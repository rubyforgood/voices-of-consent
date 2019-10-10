# The enum of premissions
# We can turn this into a database model later if we need the flexibility
# It's possible to make these IDs instead of strings. I like the legibility of the strings, and given the likely size of the dataset, the additional performance of IDs feels unecessary at the moment. That said, it may still be a mistake to use strings instead of IDs, for which I apologize.
module Permission
  REQUEST_REVIEWER = 'reviewer'
  BOX_DESIGNER = 'designer'
  BOX_ASSEMBLER = 'assembler'
  BOX_ITEM_RESEARCHER = 'researcher'
  TEAM_LEAD = 'team lead'
  SHIPPER = 'shipper'
  REIMBURSER = 'reimburser'
  PURCHASER = 'purchaser'
  VIEW_PURCHASES = 'view purchases'
  VIEW_BOX_REQUESTS = 'view box requests'
  REVIEW_FEEDBACK = 'review feedback'
  WRITE_THANKYOUS = 'write thank you notes'
  VOLUNTEER_AT_EVENTS = 'volunteer at events'
  MANAGE_USERS = 'manage users'
  VIEW_MESSAGE_LOGS = 'view message logs'
  # add new permissions above this line; new constants that are not permissions must go below AVAILABLE_PERMISSIONS=
  AVAILABLE_PERMISSIONS = self.constants.each_with_object({}) {|c, permissions| permissions[c] = self.const_get(c) }
end