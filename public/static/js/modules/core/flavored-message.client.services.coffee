define [
    'cs!./core.client.module'
    'cs!./message.client.services'
], (moduleCore) ->

    moduleCore.service 'flavoredMessage', [
        'message'
        (message) ->
            flavor =
                greeting: [
                    'My app may grant you the ability to calculate your working hours effortlessly, or may not...'
                    'Yo! That\'s my ice-cool app and it has frozen buttons!'
                    'I would tell you something about this app, but you wouldn\'t understand it anyway...'
                    'You work, I calculate how much. That\'s all you need to know.'
                ]
                success: [
                    'Boom! It\'s done!'
                    'Great success!'
                    'You may have succeed now, but next time it won\'t be so easy...'
                    'Yes it\'s done.'
                ]
                cancel: [
                    'I knew you wouldn\'t do it.'
                    'Yeah, better leave it alone.'
                    'Why bother anyway?'
                    'No, you pressed the wrong button!'
                ]
                quote: [
                    'What?'
                    'I\'m a banana.'
                    'Finish him off, my semi-loyal pet!'
                    'Gunter, you\'re embarrassing me!'
                    'Your hat is stupid!'
                    'You\'ve raised my frosty dander!'
                    'Gunter was PREGGERS!'
                    'Do you know what Ice King MEANS?!'
                    'I\'ll show you fun. Fun is my middle name!'
                    'Ladies! I brought you a baby, and a puppy!'
                    'I have to go potty in the bathroom.'
                    'PLEASE stop Ricardio!'
                    'No Ice-o-pede!'
                    'FINN! Why can\'t you ever be a princess?'
                    'These bars won\'t hold me forever- hey, there\'s only like two of them.'
                    'So let me get this straight. You\'re hitting on me.'
                    'Woah, Ice-o-pede!'
                    'Gunter, who told you you could fly?'
                    'Crush him! Crush him like you crushed me!'
                    'Now finally I can kill you! Oh wait, silly willy, I was supposed to tell you that I\'m getting married!'
                    'No one sucks the life from my penguins except ME...and maybe polar bears, because that\'s just nature Gunter.'
                    'Gunter, pick up Finn\'s dead carcass.'
                    'Game time!'
                    'Fat fat fat. Daddy\'s little fatty.'
                    'I am the king! I am the king of c-c-cool!'
                    'I\'ve soiled my tunic, completely by choice!'
                    'Hmm, yogurt chip.'
                    'I just want to be happy!'
                    'Is that really all the ice you have?'
                    'Strangling the groom\'s nose at a wedding?! What\'s wrong with you?!'
                    'Finn! You have destroyed my faith in canned peanut brittle!'
                    'I\'m toying with you, psychologically!'
                    'I\'m rocking your world view!'
                    'This is where she used to do her business.'
                    'What\'s taking that doctor so long? Gunter, make more noise.'
                    'Yeah all right, all right. Don\'t oversell it, drama queen.'
                    'But I\'ve committed no RECENT crimes.'
                    'Hey. I had to keep an eye on the Princess because she\'s being possessed by the Lich.'
                    'In the well, I saw something come out of the Lich and go into the Princess. But I wasn\'t sure it was real.'
                    'Because when you have stanky old Wizard Eyes, sometimes you see things that are real, and sometimes you see things that are crazy, crazy crazy, in your face, all the time. All the time.'
                    'Okay, I didn\'t kill her this time. Everybody saw that, right?'
                    'Oops...I\'ve got the dropsies.'
                    'WHAT!? No one commands the Ice King to make no sandwich!'
                    'Aww dang it! Well I\'m out of here. Goodbye everyone.'
                    'Wow, you\'re really fast...and quiet...and very good at dramatic silence I like it.'
                    'You know what happens when you\'re burned alive? Your eyeballs explode. Blech.'
                    'Look a supermodel! Look a hoverboard! Look, the apocalypse! Somebody got hit in the boingloings! Boingloings! Boingloings! Somebody got hit in them. Peace out!'
                    'I take artistic black-and-white photographs of my penguin\'s body parts.'
                    'Rate me on a scale of 1 to 10: 1 is "totally gross", 10 is "hey, Ice King you look crazy siiiiick!"'
                    '"Ice King is the hottest hottie, and I can\'t wait to marry him!" said Fionna. Then, she turned to Prince Gumball and said "I hope Ice King will sweep me off my feet and take me to the farthest corner of Ooo, where we will do nothing but kiss and eat a whole bunch, until we get fat and die." The end.'
                    'We could learn a thing or two from those sandwiches.'
                ]
            api =
                get: (key) ->
                    result = key
                    if flavor[key]?
                        min = 0
                        max = flavor[key].length
                        r = Math.floor(Math.random() * (max - min)) + min
                        result = flavor[key][r]
                    if Array.isArray result
                        sentences = result.map (arg) -> api.get arg
                        result = sentences.join ' '
                    result
                set: ->
                    args = Array.prototype.slice.call arguments
                    message.set api.get args
            api
    ]