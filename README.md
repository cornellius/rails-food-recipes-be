## Goal

> **It's dinner time! Create a Rails + React.js application that helps users find the most relevant recipes that they can prepare with the ingredients that they have at home**

## The prototype

Prototype in this case means:

- something usable, yet as simple as possible
- with Rails, SQL database, React.js on the front-end
- UI / design is not important
- Not adding features which are outside the basic scope of the problem
- Mainly focus on code quality & user experience, not UX/UI polishment

## Solution & general notes

- Some context about me: my professional experince as a developer spans between 2000-2016, the main programming languages during that time were Python, PHP, javascript (node, react). Later on I focused on leadership positions (Head of development, CTO) and whereas I continued coding until ~2021, it was in a much reduced way. During 2022-2024 I have been managing 4 SWE teams that were using Rails, Elixir, Kotlin as main programming languages. I was able to understand their code solutions and participate in architecture design if needed. 
- This is my 2nd foray into Rails recently, which I have really enjoyed working with because of its simplicity and user-friendliness. I have tried to code a streamlined and simple solution, taking into account performance (avoiding N+1 queries, etc.). I am sure there may be better ways to implement things in Rails, but these have worked for me very nicely. As Rails is still very much active in the startup side of things, I'll keep learning it. 
- I have chosen PostgreSQL as a relational database, and the `jsonb` type column to store the recipes after the importation. Main reason for jsonb would be designing this solution as a prototype that has some room for growth, and maybe rethink the database model in the future if some performance and/or design complications arise.
- With that spirit I have decided to create the Author and Category entities and populate them when importing. This way, authentication and user management could be added relatively easily. Also, during the initial importation, I have added some logic to create memory lists for authors and categories, to avoid querying the database unnecessarily.
- In general I haven't found major complications while implementing this solution with Rails, some minor difficulties that I can remember have been solving CORS bewteen Rails & React in a local Docker setup, and authentication in the controllers, solved via `protect_from_forgery with: :null_session`.
- I have created a simple React app on the front-end, using simple React state management, API consumption via fetch() hook, and components.
- I have dockerized the whole solutions as I would normally do for any development environment. In terms of React, two instances of it can be triggered: 1. via `npm run start` (http://localhost:3001), and 2. via `docker build -t frontend:latest .` & `docker compose up` (http://localhost)
- I have not implemented unit testing nor in Rails or React for this exercise as requested, albeit this is something I would totally do on a real scenario.
- As mentioned, I have really enjoyed implementing this solution. It has been great to get to coding an integral solution (infra, BE, FE) again :-) Thanks for the opportunity!


