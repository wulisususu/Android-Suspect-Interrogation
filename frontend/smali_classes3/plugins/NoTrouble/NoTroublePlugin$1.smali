.class Lplugins/NoTrouble/NoTroublePlugin$1;
.super Landroid/content/BroadcastReceiver;
.source "NoTroublePlugin.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lplugins/NoTrouble/NoTroublePlugin;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lplugins/NoTrouble/NoTroublePlugin;


# direct methods
.method constructor <init>(Lplugins/NoTrouble/NoTroublePlugin;)V
    .locals 0

    iput-object p1, p0, Lplugins/NoTrouble/NoTroublePlugin$1;->this$0:Lplugins/NoTrouble/NoTroublePlugin;

    .line 52
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 8

    .line 56
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    const-string v1, "title"

    .line 57
    invoke-virtual {p2, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "summary"

    .line 58
    invoke-virtual {p2, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "ext"

    .line 61
    invoke-virtual {p2, v5}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 63
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "\u8fd4\u56de\u6570\u636e\uff1a"

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    const-string v7, "\u626b\u7801\u670d\u52a1"

    invoke-static {v7, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v6, "push.notification"

    .line 65
    invoke-virtual {v6, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    const/4 v7, 0x0

    if-eqz v6, :cond_0

    const-string v0, "\u5e7f\u64ad\u901a\u77e5\u6536\u5230\u4e86"

    .line 66
    invoke-static {p1, v0, v7}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    goto :goto_0

    :cond_0
    const-string v6, "push.notification_opened"

    .line 68
    invoke-virtual {v6, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1

    const-string v0, "\u5e7f\u64ad\u901a\u77e5\u6253\u5f00\u4e86"

    .line 70
    invoke-static {p1, v0, v7}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    const/4 v7, 0x1

    goto :goto_0

    :cond_1
    const-string v6, "push.notification_removed"

    .line 72
    invoke-virtual {v6, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    const-string v0, "\u5e7f\u64ad\u901a\u77e5\u5220\u9664\u4e86"

    .line 73
    invoke-static {p1, v0, v7}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    goto :goto_0

    :cond_2
    const-string v6, "push.message"

    .line 75
    invoke-virtual {v6, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    const-string v0, "\u5e7f\u64ad\u4fe1\u606f\u900f\u4f20\u6536\u5230\u4e86"

    .line 76
    invoke-static {p1, v0, v7}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    :cond_3
    :goto_0
    if-eqz v2, :cond_4

    .line 79
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_4

    .line 80
    new-instance p1, Lcom/getcapacitor/JSObject;

    invoke-direct {p1}, Lcom/getcapacitor/JSObject;-><init>()V

    .line 81
    invoke-virtual {p1, v1, v2}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    .line 82
    invoke-virtual {p1, v3, v4}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    .line 83
    invoke-virtual {p1, v5, p2}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    const-string p2, "clickOpen"

    .line 84
    invoke-virtual {p1, p2, v7}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Z)Lcom/getcapacitor/JSObject;

    iget-object p2, p0, Lplugins/NoTrouble/NoTroublePlugin$1;->this$0:Lplugins/NoTrouble/NoTroublePlugin;

    const-string v0, "remote.notification"

    .line 86
    invoke-static {p2, v0, p1}, Lplugins/NoTrouble/NoTroublePlugin;->access$000(Lplugins/NoTrouble/NoTroublePlugin;Ljava/lang/String;Lcom/getcapacitor/JSObject;)V

    :cond_4
    return-void
.end method
