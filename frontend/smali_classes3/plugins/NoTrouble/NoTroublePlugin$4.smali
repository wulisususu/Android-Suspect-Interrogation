.class Lplugins/NoTrouble/NoTroublePlugin$4;
.super Ljava/lang/Object;
.source "NoTroublePlugin.java"

# interfaces
.implements Lcom/alibaba/sdk/android/push/CommonCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lplugins/NoTrouble/NoTroublePlugin;->getNotificationPushStatus(Lcom/getcapacitor/PluginCall;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lplugins/NoTrouble/NoTroublePlugin;

.field final synthetic val$call:Lcom/getcapacitor/PluginCall;


# direct methods
.method constructor <init>(Lplugins/NoTrouble/NoTroublePlugin;Lcom/getcapacitor/PluginCall;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    iput-object p1, p0, Lplugins/NoTrouble/NoTroublePlugin$4;->this$0:Lplugins/NoTrouble/NoTroublePlugin;

    iput-object p2, p0, Lplugins/NoTrouble/NoTroublePlugin$4;->val$call:Lcom/getcapacitor/PluginCall;

    .line 274
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailed(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object p1, p0, Lplugins/NoTrouble/NoTroublePlugin$4;->this$0:Lplugins/NoTrouble/NoTroublePlugin;

    .line 285
    iget-object p1, p1, Lplugins/NoTrouble/NoTroublePlugin;->pushChannelOpenedData:Landroidx/lifecycle/MutableLiveData;

    const/4 p2, 0x0

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroidx/lifecycle/MutableLiveData;->setValue(Ljava/lang/Object;)V

    .line 286
    new-instance p1, Lcom/getcapacitor/JSObject;

    invoke-direct {p1}, Lcom/getcapacitor/JSObject;-><init>()V

    iget-object p2, p0, Lplugins/NoTrouble/NoTroublePlugin$4;->this$0:Lplugins/NoTrouble/NoTroublePlugin;

    .line 287
    iget-object p2, p2, Lplugins/NoTrouble/NoTroublePlugin;->pushChannelOpenedData:Landroidx/lifecycle/MutableLiveData;

    invoke-virtual {p2}, Landroidx/lifecycle/MutableLiveData;->getValue()Ljava/lang/Object;

    move-result-object p2

    const-string v0, "flag"

    invoke-virtual {p1, v0, p2}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lcom/getcapacitor/JSObject;

    iget-object p2, p0, Lplugins/NoTrouble/NoTroublePlugin$4;->val$call:Lcom/getcapacitor/PluginCall;

    .line 288
    invoke-virtual {p2, p1}, Lcom/getcapacitor/PluginCall;->resolve(Lcom/getcapacitor/JSObject;)V

    return-void
.end method

.method public onSuccess(Ljava/lang/String;)V
    .locals 2

    iget-object p1, p0, Lplugins/NoTrouble/NoTroublePlugin$4;->this$0:Lplugins/NoTrouble/NoTroublePlugin;

    .line 277
    iget-object p1, p1, Lplugins/NoTrouble/NoTroublePlugin;->pushChannelOpenedData:Landroidx/lifecycle/MutableLiveData;

    const/4 v0, 0x1

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroidx/lifecycle/MutableLiveData;->setValue(Ljava/lang/Object;)V

    .line 278
    new-instance p1, Lcom/getcapacitor/JSObject;

    invoke-direct {p1}, Lcom/getcapacitor/JSObject;-><init>()V

    iget-object v0, p0, Lplugins/NoTrouble/NoTroublePlugin$4;->this$0:Lplugins/NoTrouble/NoTroublePlugin;

    .line 279
    iget-object v0, v0, Lplugins/NoTrouble/NoTroublePlugin;->pushChannelOpenedData:Landroidx/lifecycle/MutableLiveData;

    invoke-virtual {v0}, Landroidx/lifecycle/MutableLiveData;->getValue()Ljava/lang/Object;

    move-result-object v0

    const-string v1, "flag"

    invoke-virtual {p1, v1, v0}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lcom/getcapacitor/JSObject;

    iget-object v0, p0, Lplugins/NoTrouble/NoTroublePlugin$4;->val$call:Lcom/getcapacitor/PluginCall;

    .line 280
    invoke-virtual {v0, p1}, Lcom/getcapacitor/PluginCall;->resolve(Lcom/getcapacitor/JSObject;)V

    return-void
.end method
