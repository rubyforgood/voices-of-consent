# frozen_string_literal: true

handout = "Handout: #{Faker::Space.meteorite}"
novel = "Novel: #{Faker::Book.title}"
other = Faker::House.furniture.titleize
referral_source = %w[google friends family newspaper school other]

box_items = [
  ['Chapstick', %w[physical sexual emotional], %w[0-12 12+]],
  ['Floss', %w[physical sexual emotional], %w[0-12 12+]],
  ['Lotion', %w[physical sexual emotional], %w[0-12 12+]],
  ['Nail Polish', %w[physical sexual emotional], %w[0-12 12+]],
  [other, %w[physical sexual emotional], %w[0-12]],
  [handout, %w[physical sexual emotional], %w[12+]],
  [novel, %w[physical sexual emotional], %w[12+]],
  ['Pads', %w[physical sexual emotional], %w[0-12 12+]],
  ['Tampons', %w[physical sexual emotional], %w[0-12 12+]],
  ['Toothbrush', %w[physical sexual emotional], %w[0-12 12+]],
  ['Toothpaste', %w[physical sexual emotional], %w[0-12 12+]]
]

box_items.each do |inventory_type_name, abuse_types, _age_ranges|
  abuse_types.each do |abuse_type_name|
    # age_ranges.each do |age_range| for later use
    inventory_type =
      InventoryType.where('name ILIKE ?', inventory_type_name).first_or_create!(
        name: inventory_type_name
      )
    abuse_type =
      AbuseType.where('name ILIKE ?', abuse_type_name).first_or_create!(
        name: abuse_type_name
      )
    CoreBoxItem.joins(:abuse_type, :inventory_type).where(
      abuse_type: abuse_type, inventory_type: inventory_type
    ).first_or_create!
  end
end

40.times do |i|
  is_underage = [
    { boolean: false, value: '12+' },
    { boolean: true, value: 'UNDERAGE' }
  ].sample

  requester =
    Requester.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.unique.email,
      street_address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      zip: Faker::Address.zip,
      county:
        # I know this is not a county, but there are no counties in Faker
        Faker::Address.country,
      phone:
        [
          Faker::Number.number(3),
          Faker::Number.number(3),
          Faker::Number.number(4)
        ].join('-'),
      ok_to_email: [true, false].sample,
      ok_to_text: [true, false].sample,
      ok_to_call: [true, false].sample,
      ok_to_mail: [true, false].sample,
      underage: is_underage[:boolean]
    )

  is_safe = [
    { boolean: false, value: 'NOT SAFE' },
    { boolean: true, value: 'safe' }
  ].sample
  is_interested_in_health_services = [
    { boolean: false, value: nil },
    { boolean: true, value: 'health_services' }
  ].sample
  is_interested_in_counseling_services = [
    { boolean: false, value: nil },
    { boolean: true, value: 'counseling' }
  ].sample

  box_request =
    BoxRequest.create!(
      summary: nil,
      question_re_current_situation: Faker::Books::Dune.quote,
      question_re_affect: Faker::Movies::HitchhikersGuideToTheGalaxy.quote,
      question_re_referral_source: referral_source.sample,
      question_re_if_not_self_completed: Faker::Relationship.familial,
      requester_id: requester.id,
      is_interested_in_counseling_services:
        is_interested_in_counseling_services[:boolean],
      is_interested_in_health_services:
        is_interested_in_health_services[:boolean],
      is_safe: is_safe[:boolean],
      aasm_state: 'requested'
    )

  box_request_abuse_type =
    BoxRequestAbuseType.create!(
      box_request_id: box_request.id,
      abuse_type_id: AbuseType.order(Arel.sql('RANDOM()')).first.id
    )

  box_request.tag_list = [
    box_request_abuse_type.abuse_type.name,
    is_underage[:value],
    is_safe[:value],
    is_interested_in_counseling_services[:value],
    is_interested_in_health_services[:value]
  ].compact

  box_request.save!

  user = User.first

  box = Box.create!(box_request_id: box_request.id)

  MessageLog.create!(
    content: "message-log-box-request #{i}",
    delivery_type: [0, 1, 2, 3].sample,
    delivery_status: %w[pending complete].sample,
    sent_by: user,
    messageable: box_request,
    sendable: box_request,
    message_type: 'followup_email',
    message_channel: 'email',
    subject_line: 'subject'
  )

  MessageLog.create!(
    content: "message-log-box #{i}",
    delivery_type: [0, 1, 2, 3].sample,
    delivery_status: %w[pending complete].sample,
    sent_by: user,
    messageable: box,
    sendable: box,
    message_type: 'followup_email',
    message_channel: 'email',
    subject_line: 'subject'
  )

  Location.create!(
    name: Faker::Address.street_name,
    street_address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip: Faker::Address.zip,
    location_type: [0, 1, 2, 3, 4, 5].sample
  )
end

# inventory_tallies
10.times do
  InventoryTally.create(
    additional_location_info: Faker::Address.secondary_address,
    inventory_type: InventoryType.last,
    storage_location: Location.last
  )
end
