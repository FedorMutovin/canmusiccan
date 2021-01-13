import consumer from "./consumer"

$(document).on("turbolinks:load", function(e) {

    consumer.subscriptions.create("MessagesChannel", {
        connected: function() {
            return this.perform('follow', {conversation_id: gon.conversation_id });
        },
        received(data) {
            console.log(data.message.user)
            if (!(gon.user_id === data.user_id)) {
                const template = require("./handlebars/message.hbs")(data);
                $(".messages").append(template);
            }
        }
    });
})