require 'rest-client'

https://www.google.com/search?biw=1920&bih=905&tbm=isch&q=tesla+logo&revid=1824843206&sa=X&ved=0ahUKEwjs7IjYv6_MAhVEwmMKHZ0vD7cQ1QIIHw#imgrc=_
# transparent:
name = "Yahoo! Inc"
site = "https://www.google.com/search?q=#{name}+logo&tbs=ic:trans&tbm=isch&tbas=0&source=lnt&sa=X&ved=0ahUKEwjYipaC8K_MAhURymMKHZ9UCz0QpwUIFA&dpr=1&biw=1920&bih=686"

response = RestClient.get site

