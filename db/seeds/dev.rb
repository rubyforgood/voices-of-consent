handout = "Handout: #{Faker::Space.meteorite}"
novel = "Novel: #{Faker::Book.title}"
other = Faker::House.furniture.titleize
referral_source = ["google", "friends", "family", "newspaper", "school", "other"]

box_items = [
    ["Chapstick", ["physical", "sexual", "emotional"], ["0-12","12+"]],
    ["Floss",["physical", "sexual", "emotional"], ["0-12","12+"]],
    ["Lotion",["physical", "sexual", "emotional"], ["0-12","12+"]],
    ["Nail Polish",["physical", "sexual", "emotional"], ["0-12","12+"]],
    [other,["physical", "sexual", "emotional"], ["0-12"]],
    [handout,["physical", "sexual", "emotional"], ["12+"]],
    [novel,["physical", "sexual", "emotional"], ["12+"]],
    ["Pads",["physical", "sexual", "emotional"], ["0-12","12+"]],
    ["Tampons",["physical", "sexual", "emotional"], ["0-12","12+"]],
    ["Toothbrush",["physical", "sexual", "emotional"], ["0-12","12+"]],
    ["Toothpaste",["physical", "sexual", "emotional"], ["0-12","12+"]]
]

box_items.each do |inventory_type_name, abuse_types, age_ranges|
  abuse_types.each do |abuse_type_name|
    #age_ranges.each do |age_range| for later use
    inventory_type = InventoryType.where("name ILIKE ?", inventory_type_name).first_or_create!(name: inventory_type_name)
    abuse_type = AbuseType.where("name ILIKE ?", abuse_type_name).first_or_create!(name: abuse_type_name)
    CoreBoxItem.joins(:abuse_type, :inventory_type).where(abuse_type: abuse_type, inventory_type: inventory_type).first_or_create!
  end
end

40.times do
  is_underage = [{boolean: false, value: "12+"}, { boolean: true, value: "UNDERAGE"}].sample

  requester = Requester.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    street_address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip: Faker::Address.zip,
    # I know this is not a county, but there are no counties in Faker
    county: Faker::Address.country,
    phone: [Faker::Number.number(3), Faker::Number.number(3), Faker::Number.number(4)].join('-'),
    ok_to_email: [true, false].sample,
    ok_to_text: [true, false].sample,
    ok_to_call: [true, false].sample,
    ok_to_mail: [true, false].sample,
    underage: is_underage[:boolean]
  )

  is_safe = [{boolean: false, value: "NOT SAFE"}, { boolean: true, value: "safe"}].sample
  is_interested_in_health_services = [{boolean: false, value: nil}, { boolean: true, value: "health_services"}].sample
  is_interested_in_counseling_services = [{boolean: false, value: nil}, { boolean: true, value: "counseling"}].sample

  box_request = BoxRequest.create!(
    summary: nil,
    question_re_current_situation: Faker::Books::Dune.quote,
    question_re_affect: Faker::Movies::HitchhikersGuideToTheGalaxy.quote,
    question_re_referral_source: referral_source.sample,
    question_re_if_not_self_completed: Faker::Relationship.familial,
    requester_id: requester.id,
    is_interested_in_counseling_services: is_interested_in_counseling_services[:boolean],
    is_interested_in_health_services: is_interested_in_health_services[:boolean],
    is_safe: is_safe[:boolean],
    aasm_state: "requested"
  )

  box_request_abuse_type = BoxRequestAbuseType.create!(
    box_request_id: box_request.id,
    abuse_type_id: AbuseType.order(Arel.sql("RANDOM()")).first.id
  )

  box_request.tag_list = [
    box_request_abuse_type.abuse_type.name,
    is_underage[:value],
    is_safe[:value],
    is_interested_in_counseling_services[:value],
    is_interested_in_health_services[:value]
  ].compact

  box_request.save!
end

