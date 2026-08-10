.class Lcom/taobao/accs/messenger/b;
.super Landroid/os/Handler;
.source "Taobao"


# instance fields
.field final synthetic a:Lcom/taobao/accs/messenger/MessengerService;


# direct methods
.method constructor <init>(Lcom/taobao/accs/messenger/MessengerService;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/messenger/b;->a:Lcom/taobao/accs/messenger/MessengerService;

    .line 25
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 2

    if-eqz p1, :cond_0

    .line 29
    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object p1

    const-string v0, "intent"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Landroid/content/Intent;

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/messenger/b;->a:Lcom/taobao/accs/messenger/MessengerService;

    .line 31
    invoke-static {v0}, Lcom/taobao/accs/messenger/MessengerService;->a(Lcom/taobao/accs/messenger/MessengerService;)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    new-instance v1, Lcom/taobao/accs/messenger/c;

    invoke-direct {v1, p0, p1}, Lcom/taobao/accs/messenger/c;-><init>(Lcom/taobao/accs/messenger/b;Landroid/content/Intent;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    :cond_0
    return-void
.end method
