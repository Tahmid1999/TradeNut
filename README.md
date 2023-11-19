https://github.com/Tahmid1999/TradeNut/assets/31489330/71a22d38-104e-4628-a7e0-8852a0486f2e
# Application Features

Hey there! 👋 I wanted to give you a rundown of the awesome features our app brings to the table. Let's dive in!

## 1. Authorization in the Client Account Service (Peanut)

I've set things up so that you can log in seamlessly to your Peanut account. No need to repeatedly enter your login and password. I've hooked it up to the POST method [`IsAccountCredentialsCorrect`](https://peanut.ifxdb.com/docs/clientcabinet/index.html) from the REST service. This method tosses back an access token with a limited lifespan.

Oh, and just in case the token expires, I've made sure the app handles that gracefully. By the way, here are some test account credentials you can use:
- **Login:** 2088888
- **Password:** ral11lod

And, of course, I've given you the power to log out and log back in whenever you please.

## 2. Fetching User Profile Personal Data from the Peanut Service

To make things even smoother, I've implemented the use of methods like `GetAccountInformation` and `GetLastFourNumbersPhone` to grab your personal data. The Swagger documentation has all the details. Just remember to throw in your login and the token we got from the authentication method in step 1.

Now you can easily check out basic information about your account. Pretty nifty, right?

## 3. Fetching a List of User Trades from the Peanut Service

I've hooked up the `GetOpenTrades` method from the Peanut service to fetch your list of trades. The Swagger documentation has the nitty-gritty details. Again, don't forget to include your login and the authentication token from step 1.

The user interface is designed to make your life easier. Scroll through your trades effortlessly, and refresh the list with a simple button press or a swipe from the top.

## 4. Calculation and Display of the User's Profit Amount

Now, let's talk about your profits. I've crunched the numbers using the data from point 3. Your total profit amount, as per the "profit" field in the method's response, is right there for you to see. Watch it update as your list changes.

## 5. List of Promotional Campaigns (Additional, Optional Task)

Feeling extra? I've added a cool feature to showcase promotional campaigns. Using the `GetCCPromo` method from the SOAP service [here](https://api-forexcopy.contentdatapro.com/Services/CabinetMicroService.svc), you can explore what's up for grabs. No need to authenticate here.

Results are neatly presented in the form of "cards" with hyperlinks for easy navigation. Enjoy exploring! 🚀
