# WAiSTE

Our waste management app uses AI to identify if items are trash, recyclable, or compostable. We use Azure AI Vision to identify objects from photos uploaded to our app. Those identified tags are then fed into our OpenAI API which is trained to sort the items into trash, recyclable, or compostable. Afterwards, we call the Azure Cognitive Speech API to read aloud the category the item has been sorted into, in order to enhance the accessibility of our app.

When first loaded, the app prompts the user for their login information. After the user is logged in, they are shown to a page where they can upload an image or take a photo of an item. Afterwards, the app will identify what object the item is and determine whether its trash, recyclable or compostable. This message will be read aloud to the user as well. In addition, the app will have a second mode where the user can enter text of what the item is. This will be sent to the OpenAI API to sort that item into trash, recyclable, or compostable and alert the user.

Figma UI: https://www.figma.com/file/8qPCfN8FecsWP9YcsurQQU/WAiSTE?type=design&node-id=0%3A1&mode=design&t=Lrt2QUghlBbNME7f-1 
