.class Lcom/darryncampbell/cordova/plugin/intent/IntentShim$1;
.super Landroid/content/BroadcastReceiver;
.source "IntentShim.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/darryncampbell/cordova/plugin/intent/IntentShim;->newBroadcastReceiver()Landroid/content/BroadcastReceiver;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/darryncampbell/cordova/plugin/intent/IntentShim;


# direct methods
.method constructor <init>(Lcom/darryncampbell/cordova/plugin/intent/IntentShim;)V
    .locals 0

    iput-object p1, p0, Lcom/darryncampbell/cordova/plugin/intent/IntentShim$1;->this$0:Lcom/darryncampbell/cordova/plugin/intent/IntentShim;

    .line 644
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 3

    .line 647
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    iget-object p1, p0, Lcom/darryncampbell/cordova/plugin/intent/IntentShim$1;->this$0:Lcom/darryncampbell/cordova/plugin/intent/IntentShim;

    .line 648
    invoke-static {p1}, Lcom/darryncampbell/cordova/plugin/intent/IntentShim;->-$$Nest$fgetreceiverCallbacks(Lcom/darryncampbell/cordova/plugin/intent/IntentShim;)Ljava/util/Map;

    move-result-object p1

    invoke-interface {p1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lorg/apache/cordova/CallbackContext;

    if-eqz p1, :cond_0

    .line 651
    new-instance v0, Lorg/apache/cordova/PluginResult;

    sget-object v1, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    iget-object v2, p0, Lcom/darryncampbell/cordova/plugin/intent/IntentShim$1;->this$0:Lcom/darryncampbell/cordova/plugin/intent/IntentShim;

    invoke-static {v2, p2}, Lcom/darryncampbell/cordova/plugin/intent/IntentShim;->-$$Nest$mgetIntentJson(Lcom/darryncampbell/cordova/plugin/intent/IntentShim;Landroid/content/Intent;)Lorg/json/JSONObject;

    move-result-object p2

    invoke-direct {v0, v1, p2}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;Lorg/json/JSONObject;)V

    const/4 p2, 0x1

    .line 652
    invoke-virtual {v0, p2}, Lorg/apache/cordova/PluginResult;->setKeepCallback(Z)V

    .line 653
    invoke-virtual {p1, v0}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    :cond_0
    return-void
.end method
