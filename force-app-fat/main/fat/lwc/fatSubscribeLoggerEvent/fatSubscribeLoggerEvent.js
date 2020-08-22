/**
 * @name fatSubscribeLoggerEvent.js
 * @see https://developer.salesforce.com/docs/component-library/bundle/lightning-emp-api
 */
import { LightningElement } from 'lwc';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';

export default class FatSubscribeLoggerEvent extends LightningElement {
  channelName = '/event/FAT_LoggerEvent__e';
  isSubscribeDisabled = false;
  isUnsubscribeDisabled = !this.isSubscribeDisabled;

  subscription = {};

  // Tracks changes to channelName text field
  handleChannelName(event) {
    this.channelName = event.target.value;
  }

  // Initializes the component
  connectedCallback() {
    // Register error listener
    this.registerErrorListener();
  }

  // Handles subscribe button click
  handleSubscribe() {
    // Callback invoked whenever a new event message is received
    const messageCallback = (response) => {
      const event = JSON.parse(JSON.stringify(response)).data.event;
      const payload = JSON.parse(JSON.stringify(response)).data.payload;
      console.log('New message - replayId:');
      console.log(event.replayId);
      // Response contains the payload of the new message received
      const debugLogs = JSON.parse(payload.Logger__c).debugLogs;
      debugLogs.forEach((log) => {
        console.log(log);
      });
    };

    // Invoke subscribe method of empApi. Pass reference to messageCallback
    subscribe(this.channelName, -1, messageCallback).then((response) => {
      // Response contains the subscription information on subscribe call
      console.log(
        'Subscription request sent to: ',
        JSON.stringify(response.channel)
      );
      this.subscription = response;
      this.toggleSubscribeButton(true);
    });
  }

  // Handles unsubscribe button click
  handleUnsubscribe() {
    this.toggleSubscribeButton(false);

    // Invoke unsubscribe method of empApi
    unsubscribe(this.subscription, (response) => {
      console.log('unsubscribe() response: ', JSON.stringify(response));
      // Response is true for successful unsubscribe
    });
  }

  toggleSubscribeButton(enableSubscribe) {
    this.isSubscribeDisabled = enableSubscribe;
    this.isUnsubscribeDisabled = !enableSubscribe;
  }

  registerErrorListener() {
    // Invoke onError empApi method
    onError((error) => {
      console.log('Received error from server: ', JSON.stringify(error));
      // Error contains the server-side error
    });
  }
}
