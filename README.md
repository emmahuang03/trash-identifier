# WAiSTE

WAiSTE is a waste management app that uses AI to sort items into their correct trash, recyclable, or compostable bins. Our app innovatively minimizes misplaced garbage by allowing users to simply use their phones to make a meaningful impact regardless of background or expertise.

Unlike other waste sorting apps, WAiSTE is designed to handle both image and text inputs. We support all users including those who are visually impaired by adding a voice model that narrates the category. Our app uses AI to provide a description of the positive impact users are actively creating by recycling the item, as well as educate the user on ways to avoid misplacing it in the future.

When first loaded, the app prompts the user for their login information. After the user is logged in, they are shown to a page where they can upload an image or take a photo of an item. Afterwards, the app will identify what object the item is and determine whether its trash, recyclable or compostable. This message will be read aloud to the user as well. In addition, the app will have a second mode where the user can enter text of what the item is. This will be sent to the OpenAI API to sort that item into trash, recyclable, or compostable and alert the user.

We use Azure AI Vision to identify objects from photos uploaded to our app. Those identified tags are then fed into our OpenAI API which is trained to sort the items into trash, recyclable, or compostable. Afterwards, we call the Azure Cognitive Speech API to read aloud the category the item has been sorted into, in order to enhance the accessibility of our app.

[Link to Figma UI](https://www.figma.com/file/8qPCfN8FecsWP9YcsurQQU/WAiSTE?type=design&node-id=0%3A1&mode=design&t=Lrt2QUghlBbNME7f-1)
