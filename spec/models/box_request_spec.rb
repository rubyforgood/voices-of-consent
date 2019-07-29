# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe BoxRequest, :type => :model do
  subject(:requester) { Requester.new(first_name: "Jane", last_name: "Doe", street_address: "122 Boggie Woogie Avenue", city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false, ok_to_mail: true, underage: false) }
  subject(:box_request) { BoxRequest.new }

 it "is valid with valid attributes" do
   box_request.requester = requester

   box_request.summary = "Lorem ipsum text.... Caramels tart sweet pudding pie candy lollipop. Fruitcake cake danish. Chupa chups jelly beans macaroon topping icing ice cream donut sesame snaps sweet roll. Tart bear claw sweet powder jelly-o. Liquorice cookie muffin I love dessert tootsie roll I love caramels chocolate bar. Cookie biscuit bear claw tiramisu chocolate cake. Cake I love lollipop. Wafer I love halvah gummi bears halvah jelly cake donut. Cupcake chupa chups sesame snaps oat cake candy canes donut lemon drops croissant tiramisu. Lemon drops chocolate I love pie. Donut dessert cheesecake powder. Cupcake gummi bears I love cheesecake croissant lollipop danish. Chupa chups I love powder soufflé carrot cake."
   box_request.question_re_affect = "Lorem ipsum text.... Tart jujubes candy canes pudding I love gummies. Biscuit liquorice macaroon candy cupcake I love I love cake croissant. Cake I love tart powder I love lollipop muffin marshmallow ice cream. Chocolate cake chocolate I love chocolate chocolate cake. Halvah dragée gingerbread chocolate jelly. "
   box_request.question_re_current_situation = "Sweet roll cake pastry cookie. Danish I love macaroon tart danish sesame snaps cheesecake donut lemon drops. Toffee sweet lemon drops cheesecake soufflé halvah donut I love. Macaroon pie danish toffee. Chocolate cake lemon drops I love croissant dessert sweet. Cotton candy chocolate cake candy. Topping jelly-o cake tart. Powder macaroon I love lemon drops wafer sweet. Jelly beans pudding cake cotton candy marzipan sweet roll sesame snaps oat cake. Sweet apple pie powder candy canes lollipop chupa chups gingerbread I love I love."
   box_request.question_re_referral_source = "Ice cream sesame snaps danish marzipan macaroon icing jelly beans. Sugar plum danish gingerbread I love halvah. Lemon drops tart dessert. Jelly jelly lemon drops jelly-o fruitcake cookie topping topping jelly beans. Marshmallow biscuit tiramisu bear claw sweet roll cake danish candy. Lemon drops carrot cake chocolate ice cream liquorice toffee chupa chups icing tootsie roll. Lollipop I love chupa chups. Tootsie roll croissant jelly jujubes brownie apple pie tiramisu chocolate I love. Apple pie croissant tiramisu. Wafer I love apple pie tiramisu. Chocolate bar muffin powder ice cream I love cookie sweet roll. Apple pie lollipop brownie ice cream dragée cupcake."

   expect(box_request).to be_valid
 end

 it "is invalid without requester" do
   box_request.summary = "Lorem ipsum text.... Caramels tart sweet pudding pie candy lollipop. Fruitcake cake danish. Chupa chups jelly beans macaroon topping icing ice cream donut sesame snaps sweet roll. Tart bear claw sweet powder jelly-o. Liquorice cookie muffin I love dessert tootsie roll I love caramels chocolate bar. Cookie biscuit bear claw tiramisu chocolate cake. Cake I love lollipop. Wafer I love halvah gummi bears halvah jelly cake donut. Cupcake chupa chups sesame snaps oat cake candy canes donut lemon drops croissant tiramisu. Lemon drops chocolate I love pie. Donut dessert cheesecake powder. Cupcake gummi bears I love cheesecake croissant lollipop danish. Chupa chups I love powder soufflé carrot cake."
   box_request.question_re_affect = "Lorem ipsum text.... Tart jujubes candy canes pudding I love gummies. Biscuit liquorice macaroon candy cupcake I love I love cake croissant. Cake I love tart powder I love lollipop muffin marshmallow ice cream. Chocolate cake chocolate I love chocolate chocolate cake. Halvah dragée gingerbread chocolate jelly. "
   box_request.question_re_current_situation = "Sweet roll cake pastry cookie. Danish I love macaroon tart danish sesame snaps cheesecake donut lemon drops. Toffee sweet lemon drops cheesecake soufflé halvah donut I love. Macaroon pie danish toffee. Chocolate cake lemon drops I love croissant dessert sweet. Cotton candy chocolate cake candy. Topping jelly-o cake tart. Powder macaroon I love lemon drops wafer sweet. Jelly beans pudding cake cotton candy marzipan sweet roll sesame snaps oat cake. Sweet apple pie powder candy canes lollipop chupa chups gingerbread I love I love."
   box_request.question_re_referral_source = "Ice cream sesame snaps danish marzipan macaroon icing jelly beans. Sugar plum danish gingerbread I love halvah. Lemon drops tart dessert. Jelly jelly lemon drops jelly-o fruitcake cookie topping topping jelly beans. Marshmallow biscuit tiramisu bear claw sweet roll cake danish candy. Lemon drops carrot cake chocolate ice cream liquorice toffee chupa chups icing tootsie roll. Lollipop I love chupa chups. Tootsie roll croissant jelly jujubes brownie apple pie tiramisu chocolate I love. Apple pie croissant tiramisu. Wafer I love apple pie tiramisu. Chocolate bar muffin powder ice cream I love cookie sweet roll. Apple pie lollipop brownie ice cream dragée cupcake."

   expect(box_request).to_not be_valid
 end

 it "is invalid without question_re_affect" do
   box_request.requester = requester

   box_request.summary = "Lorem ipsum text.... Tart jujubes candy canes pudding I love gummies. Biscuit liquorice macaroon candy cupcake I love I love cake croissant. Cake I love tart powder I love lollipop muffin marshmallow ice cream. Chocolate cake chocolate I love chocolate chocolate cake. Halvah dragée gingerbread chocolate jelly. "
   box_request.question_re_current_situation = "Sweet roll cake pastry cookie. Danish I love macaroon tart danish sesame snaps cheesecake donut lemon drops. Toffee sweet lemon drops cheesecake soufflé halvah donut I love. Macaroon pie danish toffee. Chocolate cake lemon drops I love croissant dessert sweet. Cotton candy chocolate cake candy. Topping jelly-o cake tart. Powder macaroon I love lemon drops wafer sweet. Jelly beans pudding cake cotton candy marzipan sweet roll sesame snaps oat cake. Sweet apple pie powder candy canes lollipop chupa chups gingerbread I love I love."
   box_request.question_re_referral_source = "Ice cream sesame snaps danish marzipan macaroon icing jelly beans. Sugar plum danish gingerbread I love halvah. Lemon drops tart dessert. Jelly jelly lemon drops jelly-o fruitcake cookie topping topping jelly beans. Marshmallow biscuit tiramisu bear claw sweet roll cake danish candy. Lemon drops carrot cake chocolate ice cream liquorice toffee chupa chups icing tootsie roll. Lollipop I love chupa chups. Tootsie roll croissant jelly jujubes brownie apple pie tiramisu chocolate I love. Apple pie croissant tiramisu. Wafer I love apple pie tiramisu. Chocolate bar muffin powder ice cream I love cookie sweet roll. Apple pie lollipop brownie ice cream dragée cupcake."

   expect(box_request).to_not be_valid
 end

 it "is invalid without question_re_current_situation" do
   box_request.requester = requester

   box_request.summary = "Lorem ipsum text.... Tart jujubes candy canes pudding I love gummies. Biscuit liquorice macaroon candy cupcake I love I love cake croissant. Cake I love tart powder I love lollipop muffin marshmallow ice cream. Chocolate cake chocolate I love chocolate chocolate cake. Halvah dragée gingerbread chocolate jelly. "
   box_request.question_re_affect = "Sweet roll cake pastry cookie. Danish I love macaroon tart danish sesame snaps cheesecake donut lemon drops. Toffee sweet lemon drops cheesecake soufflé halvah donut I love. Macaroon pie danish toffee. Chocolate cake lemon drops I love croissant dessert sweet. Cotton candy chocolate cake candy. Topping jelly-o cake tart. Powder macaroon I love lemon drops wafer sweet. Jelly beans pudding cake cotton candy marzipan sweet roll sesame snaps oat cake. Sweet apple pie powder candy canes lollipop chupa chups gingerbread I love I love."
   box_request.question_re_referral_source = "Ice cream sesame snaps danish marzipan macaroon icing jelly beans. Sugar plum danish gingerbread I love halvah. Lemon drops tart dessert. Jelly jelly lemon drops jelly-o fruitcake cookie topping topping jelly beans. Marshmallow biscuit tiramisu bear claw sweet roll cake danish candy. Lemon drops carrot cake chocolate ice cream liquorice toffee chupa chups icing tootsie roll. Lollipop I love chupa chups. Tootsie roll croissant jelly jujubes brownie apple pie tiramisu chocolate I love. Apple pie croissant tiramisu. Wafer I love apple pie tiramisu. Chocolate bar muffin powder ice cream I love cookie sweet roll. Apple pie lollipop brownie ice cream dragée cupcake."

   expect(box_request).to_not be_valid
 end

 it "is invalid without question_re_referral_source" do
   box_request.requester = requester

   box_request.summary = "Lorem ipsum text.... Tart jujubes candy canes pudding I love gummies. Biscuit liquorice macaroon candy cupcake I love I love cake croissant. Cake I love tart powder I love lollipop muffin marshmallow ice cream. Chocolate cake chocolate I love chocolate chocolate cake. Halvah dragée gingerbread chocolate jelly. "
   box_request.question_re_affect = "Sweet roll cake pastry cookie. Danish I love macaroon tart danish sesame snaps cheesecake donut lemon drops. Toffee sweet lemon drops cheesecake soufflé halvah donut I love. Macaroon pie danish toffee. Chocolate cake lemon drops I love croissant dessert sweet. Cotton candy chocolate cake candy. Topping jelly-o cake tart. Powder macaroon I love lemon drops wafer sweet. Jelly beans pudding cake cotton candy marzipan sweet roll sesame snaps oat cake. Sweet apple pie powder candy canes lollipop chupa chups gingerbread I love I love."
   box_request.question_re_current_situation = "Ice cream sesame snaps danish marzipan macaroon icing jelly beans. Sugar plum danish gingerbread I love halvah. Lemon drops tart dessert. Jelly jelly lemon drops jelly-o fruitcake cookie topping topping jelly beans. Marshmallow biscuit tiramisu bear claw sweet roll cake danish candy. Lemon drops carrot cake chocolate ice cream liquorice toffee chupa chups icing tootsie roll. Lollipop I love chupa chups. Tootsie roll croissant jelly jujubes brownie apple pie tiramisu chocolate I love. Apple pie croissant tiramisu. Wafer I love apple pie tiramisu. Chocolate bar muffin powder ice cream I love cookie sweet roll. Apple pie lollipop brownie ice cream dragée cupcake."

   expect(box_request).to_not be_valid
 end

 it "adds a tag" do
   box_request.requester = requester

   box_request.summary = "Lorem ipsum text.... Caramels tart sweet pudding pie candy lollipop. Fruitcake cake danish. Chupa chups jelly beans macaroon topping icing ice cream donut sesame snaps sweet roll. Tart bear claw sweet powder jelly-o. Liquorice cookie muffin I love dessert tootsie roll I love caramels chocolate bar. Cookie biscuit bear claw tiramisu chocolate cake. Cake I love lollipop. Wafer I love halvah gummi bears halvah jelly cake donut. Cupcake chupa chups sesame snaps oat cake candy canes donut lemon drops croissant tiramisu. Lemon drops chocolate I love pie. Donut dessert cheesecake powder. Cupcake gummi bears I love cheesecake croissant lollipop danish. Chupa chups I love powder soufflé carrot cake."
   box_request.question_re_affect = "Lorem ipsum text.... Tart jujubes candy canes pudding I love gummies. Biscuit liquorice macaroon candy cupcake I love I love cake croissant. Cake I love tart powder I love lollipop muffin marshmallow ice cream. Chocolate cake chocolate I love chocolate chocolate cake. Halvah dragée gingerbread chocolate jelly. "
   box_request.question_re_current_situation = "Sweet roll cake pastry cookie. Danish I love macaroon tart danish sesame snaps cheesecake donut lemon drops. Toffee sweet lemon drops cheesecake soufflé halvah donut I love. Macaroon pie danish toffee. Chocolate cake lemon drops I love croissant dessert sweet. Cotton candy chocolate cake candy. Topping jelly-o cake tart. Powder macaroon I love lemon drops wafer sweet. Jelly beans pudding cake cotton candy marzipan sweet roll sesame snaps oat cake. Sweet apple pie powder candy canes lollipop chupa chups gingerbread I love I love."
   box_request.question_re_referral_source = "Ice cream sesame snaps danish marzipan macaroon icing jelly beans. Sugar plum danish gingerbread I love halvah. Lemon drops tart dessert. Jelly jelly lemon drops jelly-o fruitcake cookie topping topping jelly beans. Marshmallow biscuit tiramisu bear claw sweet roll cake danish candy. Lemon drops carrot cake chocolate ice cream liquorice toffee chupa chups icing tootsie roll. Lollipop I love chupa chups. Tootsie roll croissant jelly jujubes brownie apple pie tiramisu chocolate I love. Apple pie croissant tiramisu. Wafer I love apple pie tiramisu. Chocolate bar muffin powder ice cream I love cookie sweet roll. Apple pie lollipop brownie ice cream dragée cupcake."

   box_request.tag_list.add("free_counseling")
   box_request.save
   box_request.reload
   expect(box_request.tags[0].name).to eq("free_counseling")
 end

 it "removes a tag" do
   box_request.requester = requester

   box_request.summary = "Lorem ipsum text.... Caramels tart sweet pudding pie candy lollipop. Fruitcake cake danish. Chupa chups jelly beans macaroon topping icing ice cream donut sesame snaps sweet roll. Tart bear claw sweet powder jelly-o. Liquorice cookie muffin I love dessert tootsie roll I love caramels chocolate bar. Cookie biscuit bear claw tiramisu chocolate cake. Cake I love lollipop. Wafer I love halvah gummi bears halvah jelly cake donut. Cupcake chupa chups sesame snaps oat cake candy canes donut lemon drops croissant tiramisu. Lemon drops chocolate I love pie. Donut dessert cheesecake powder. Cupcake gummi bears I love cheesecake croissant lollipop danish. Chupa chups I love powder soufflé carrot cake."
   box_request.question_re_affect = "Lorem ipsum text.... Tart jujubes candy canes pudding I love gummies. Biscuit liquorice macaroon candy cupcake I love I love cake croissant. Cake I love tart powder I love lollipop muffin marshmallow ice cream. Chocolate cake chocolate I love chocolate chocolate cake. Halvah dragée gingerbread chocolate jelly. "
   box_request.question_re_current_situation = "Sweet roll cake pastry cookie. Danish I love macaroon tart danish sesame snaps cheesecake donut lemon drops. Toffee sweet lemon drops cheesecake soufflé halvah donut I love. Macaroon pie danish toffee. Chocolate cake lemon drops I love croissant dessert sweet. Cotton candy chocolate cake candy. Topping jelly-o cake tart. Powder macaroon I love lemon drops wafer sweet. Jelly beans pudding cake cotton candy marzipan sweet roll sesame snaps oat cake. Sweet apple pie powder candy canes lollipop chupa chups gingerbread I love I love."
   box_request.question_re_referral_source = "Ice cream sesame snaps danish marzipan macaroon icing jelly beans. Sugar plum danish gingerbread I love halvah. Lemon drops tart dessert. Jelly jelly lemon drops jelly-o fruitcake cookie topping topping jelly beans. Marshmallow biscuit tiramisu bear claw sweet roll cake danish candy. Lemon drops carrot cake chocolate ice cream liquorice toffee chupa chups icing tootsie roll. Lollipop I love chupa chups. Tootsie roll croissant jelly jujubes brownie apple pie tiramisu chocolate I love. Apple pie croissant tiramisu. Wafer I love apple pie tiramisu. Chocolate bar muffin powder ice cream I love cookie sweet roll. Apple pie lollipop brownie ice cream dragée cupcake."

   box_request.tag_list.add("free_counseling")
   box_request.save
   box_request.reload

   box_request.tag_list.remove("free_counseling")
   box_request.save
   box_request.reload
   expect(box_request.tags).to eq([])
 end
end
