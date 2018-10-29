# league_mvp
A sample elixir application that serves the football results from the data provided in csv file

### Build Application
To build the application, the followi

```
iex(1)> BankMvp.Bank.register_user("bankmvp53@gmail.com", "password", 500)
{:ok, "4923263703768902"}

iex(2)> BankMvp.Bank.register_user("bsyed6@gmail.com", "password", 450)
{:error, :minimum_deposit_amount_is_500}

```
### To Deposit money into your account
To deposit money into your account, the following function needs to be called with user id, password and amount needs to be deposited.

you will get your user id and new balance in your account as a response

```
iex(3)> BankMvp.Bank.credit("4923263703768902", "password", 1250)
{"4923263703768902", 1750}

iex(4)> BankMvp.Bank.credit("4923263703768902", "password", 50)
{:error, :minimum_credit_amount_is_100}

```
