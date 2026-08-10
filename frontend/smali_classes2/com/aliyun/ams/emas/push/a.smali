.class Lcom/aliyun/ams/emas/push/a;
.super Landroid/os/Handler;
.source "Taobao"


# instance fields
.field final synthetic a:Lcom/aliyun/ams/emas/push/AgooMessageIntentService;


# direct methods
.method constructor <init>(Lcom/aliyun/ams/emas/push/AgooMessageIntentService;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/ams/emas/push/a;->a:Lcom/aliyun/ams/emas/push/AgooMessageIntentService;

    .line 24
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 2

    if-eqz p1, :cond_0

    .line 28
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object p1

    const-string v0, "intent"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Landroid/content/Intent;

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/aliyun/ams/emas/push/a;->a:Lcom/aliyun/ams/emas/push/AgooMessageIntentService;

    const/4 v1, 0x0

    .line 31
    invoke-virtual {v0, p1, v1, v1}, Lcom/aliyun/ams/emas/push/AgooMessageIntentService;->onStartCommand(Landroid/content/Intent;II)I

    :cond_0
    return-void
.end method
