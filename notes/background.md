# Background
Voices of Consent is a nonprofit organization whose goal is to support survivors after a traumatic event. In the aftermath of a traumatic event, Voices of Consent sends a box to a survivor who requests one.

Survivor Boxes are personalized packages put together to let survivors know they are not alone after an event, and includes resources to use as survivors begin the recovery process (including information about laws in their state, free health and counseling services in their area). The boxes are sent to survivors who request them directly, or can be picked up at hospitals or police stations.

Please check out [the Voices of Consent website](https://www.voicesofconsent.org/what-we-do) to learn more about this organization.

# Application Purpose

The purpose of this application is to streamline the process of coordinating many volunteers in different locations and at different points in the lifecycle of a request. 

This scope of this application includes: 
- requesting, designing, packaging, shipping and tracking a box
- maintaining inventory supplies  
- creating and managing volunteer roles 
- managing events

# Application Features
## Primary Workflow of the Application (aka phases of Survivor Box creation) 

  ### 1. BoxRequest creation
  - Someone submits a `BoxRequest` form
    - `/requesters/new`
    - No login required
    - People select abuse types (emotional, physical, sexual, all of the above) and answer other questions that cue what types of support Voices of Consent can provide
  - Out of the form responses, we create the following via the `BoxRequestsTriageController`:
    - Requester (person who requested a form)
    - Associated `BoxRequest`
      - We prepopulate tags based on `AbuseTypes` and other form responses
  - An email is sent to all `Volunteers` (people) who have `Permission` (via their `User` account) to review box requests (BoxReviewer)
  - BoxReviewer Volunteers can either Claim or Decline review from the button in their email
    - All requests available for review are also able to be claimed via Status button in main nav (BoxRequests index)
  - 
  ### 2. Box Design
  - After a similar Claim/Decline email related to new BoxRequests, boxes get "Designed", where a Volunteer with Permission will add `BoxItems` to  a `Box`
  - The Designer will be taken to the Design page (via `BoxDesignController`), where they will select items to add to this person's box from the `Inventory Type` dropdown.
  - Users can also add new on-the-fly `BoxItems` even if there isn't an underlying `Inventory Type`
#### 2.a. BoxItem Research (resource materials creation)
  - Voices of Consent compiles resource materials specific to each person's BoxRequest data. 
    - This often requires referencing many websites, copy/pasting info into documents, adding some images/styling to make it prettier, and then saving the result as a PDF. 
    - We'd love to support/assist with that process later on, and this is the initial groundwork to add Research as a phase of Box production. 
    - Technically it's required for specific BoxItems (we don't need research on a "toothbrush", but we do on a "local resources packet"). 
    - The Researcher is often a different person than the Assembler. Once the packet PDF has been uploaded to the BoxItem, the Assembler will print the item before marking it off on the checklist of included items as part of BoxAssembly (packaging).
  ### 3. Box Assembly (Packaging) 
  - Once all the box is Designed, and via a similar Claim/Decline email someone will Claim the task of Packaging (assembling) the Box
  - They are provided with a mobile-friendly, on-screen checklist to confirm that each `BoxItem` made it in to the `Box`
  ### 4. Box Shipping
  - Similar to the other phases, after a Volunteer completes BoxAssembly, an email is sent to Volunteers with Shipping Permission
  - Volunteer Prints the mailing label and affixes it to the Box
  - Volunteer ships the package, and then `marks the box as shipped` by including `Location` it was shipped from (e.g. USPS, FedEx, etc), the cost of the receipt, and `tracking number`.  

  ### References re the above
  To check out where/how the lifecycle methods are implemented, visit:
- `aasm` blocks in the `box_request.rb` and `box.rb` models
- Check out how we determine things like `is_reviewed`, `is_shipped`, etc, by looking at those instance methods in `box_rb`
- View `box_requests/index.html.erb` file or `localhost:3000/box_requests` in your local browser to see a grid of box_requests and their lifecycle phases
- `spec/models/box_spec.rb` to see how we can manually walk `box_requests` along in the process

## Design notes
  - `Volunteers` are people (as are `Requesters`).
  - We chose to keep `Volunteers` separate from `Users` so that the User model only deals with login info.
  - We chose to put `Requester` (people who submit `BoxRequests`) data and `Volunteer` data into different tables, just so we never access `Requester` data accidentally.
  - The above phases are distinct so that the privacy of `Requesters` is preserved. For example, the person Assembling the Box likely isn't also the person affixing the mailing label, etc.
  
#### `Volunteer` and `User` model details

The `Volunteer` model is where we keep all the personal data for a person, such as phone, address, age range, etc, and these people will not necessarily be direct users of the Voices of Consent application itself aside from signing up as a volunteer.  Lots of volunteers never actually use the application itself but may for example show up at a packing party, and we are just tracking them with the `Volunteer` model.   If a `Volunteer` record is created, a `User` record is not created along with it.

The `User` model is not just tracking a volunteer’s info but is specific to the account information for a user of the application, and includes info such as a person’s site permissions, password token, etc.  A `User` record `belongs_to` the `Volunteer` model, and when a `User` record is created it will also have an associated `Volunteer` record created along with it.

## Other features
  - Inventory Management
    - Multiple locations each have inventory
    - When `BoxItems` are Assembled, they will be removed from the relevant `Location's` `InventoryTally` via an `InventoryAdjustment`
  - Volunteer Attendance Tracking
    - `Volunteers` can sign up for `Meetings` at `Locations` via `Attendance` model
    - `Attendance` can then be tracked
  - MessageLogs
    - Every time our system sends an autogenerated email, we will log it as a `MessageLog`
      - Examples include: 
        - To: Requester -- Thank you for your BoxRequest
        - To: Volunteers w BoxRequest Review permission -- A new BoxRequests exists. Please Claim or Decline.
        - To: Volunteers w BoxDesign permission - A Box is ready for review. Please Claim or Decline.
        - etc
    - We'll also allow Admins to create `MessageLogs` ad hoc, so it essentially provides basic CRM support
