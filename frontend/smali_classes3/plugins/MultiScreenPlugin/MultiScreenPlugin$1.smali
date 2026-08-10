.class Lplugins/MultiScreenPlugin/MultiScreenPlugin$1;
.super Landroid/content/BroadcastReceiver;
.source "MultiScreenPlugin.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lplugins/MultiScreenPlugin/MultiScreenPlugin;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lplugins/MultiScreenPlugin/MultiScreenPlugin;


# direct methods
.method constructor <init>(Lplugins/MultiScreenPlugin/MultiScreenPlugin;)V
    .locals 0

    iput-object p1, p0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$1;->this$0:Lplugins/MultiScreenPlugin/MultiScreenPlugin;

    .line 39
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 3

    const-string p1, "multi_screen.second_screen_message"

    .line 43
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    const-string p1, "message"

    .line 46
    invoke-virtual {p2, p1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 47
    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "\u6536\u5230\u5e7f\u64ad: "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    const-string v0, "BroadcastReceiver"

    invoke-static {v0, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 49
    :try_start_0
    new-instance p2, Lcom/getcapacitor/JSObject;

    invoke-direct {p2, p1}, Lcom/getcapacitor/JSObject;-><init>(Ljava/lang/String;)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$1;->this$0:Lplugins/MultiScreenPlugin/MultiScreenPlugin;

    const-string v1, "name"

    .line 50
    invoke-virtual {p2, v1}, Lcom/getcapacitor/JSObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "data"

    invoke-virtual {p2, v2}, Lcom/getcapacitor/JSObject;->getJSObject(Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    move-result-object p2

    invoke-static {p1, v1, p2}, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->access$000(Lplugins/MultiScreenPlugin/MultiScreenPlugin;Ljava/lang/String;Lcom/getcapacitor/JSObject;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 53
    new-instance p2, Ljava/lang/StringBuilder;

    const-string v1, "\u89e3\u6790 JSON \u5931\u8d25: "

    invoke-direct {p2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void
.end method
