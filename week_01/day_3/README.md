# API_challenge
the repository with jupyter notebooks which contain the instructions for API challenge

We will be working with the Twitter Streaming API. You can find official documentation [here](https://developer.twitter.com/en/docs/labs/filtered-stream/overview).

Goal is to stream real-time tweets to our computer and store them. We will use them later in the bootcamp. During the way, we will practice

- APIs
- Setting Up environmental variables
- Python Programming


#### Tasks:

1. We will be using python package for Twitter API (one of many) python-twitter. We can install it in our environment using `pip install python-twitter`. (15 min)
2. Before we get our application tokens (API keys) we have to create own Twitter App. Follow [these intructions](https://python-twitter.readthedocs.io/en/latest/getting_started.html).
    - you can name your application `Test Application for API Challenge at LighthouseLabs` or something simalar
    - if you don't know what  website to use, use link to this repository: https://github.com/lighthouse-labs/API_challenge. 
    - Once you have access to your keys and tokens (should be 4 overall), save them as environmental variables in your computer.
    - Test your personal details using python snippet in the instructions above. We will have to edit the code and use package os to access the values of environmental variables
3. Proceed to file `stream_tweets.ipynb` and follow the instructions in the notebook. (60 min)



