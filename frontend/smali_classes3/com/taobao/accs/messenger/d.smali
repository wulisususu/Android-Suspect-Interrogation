.class public Lcom/taobao/accs/messenger/d;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Landroid/content/ServiceConnection;


# instance fields
.field private final a:Landroid/content/Context;

.field private b:I

.field private c:Landroid/os/Messenger;

.field private final d:Ljava/lang/String;

.field private final e:Lcom/taobao/accs/messenger/a;

.field private final f:J


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Lcom/taobao/accs/messenger/a;)V
    .locals 2

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput v0, p0, Lcom/taobao/accs/messenger/d;->b:I

    .line 23
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/accs/messenger/d;->f:J

    iput-object p1, p0, Lcom/taobao/accs/messenger/d;->a:Landroid/content/Context;

    iput-object p2, p0, Lcom/taobao/accs/messenger/d;->d:Ljava/lang/String;

    iput-object p3, p0, Lcom/taobao/accs/messenger/d;->e:Lcom/taobao/accs/messenger/a;

    return-void
.end method


# virtual methods
.method public a(Landroid/content/Intent;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .line 50
    new-instance v0, Landroid/os/Message;

    invoke-direct {v0}, Landroid/os/Message;-><init>()V

    .line 51
    invoke-virtual {v0}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v1

    const-string v2, "intent"

    invoke-virtual {v1, v2, p1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    iget-object p1, p0, Lcom/taobao/accs/messenger/d;->c:Landroid/os/Messenger;

    .line 53
    invoke-virtual {p1, v0}, Landroid/os/Messenger;->send(Landroid/os/Message;)V

    return-void
.end method

.method public a()Z
    .locals 2

    iget v0, p0, Lcom/taobao/accs/messenger/d;->b:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public b()Z
    .locals 3

    iget v0, p0, Lcom/taobao/accs/messenger/d;->b:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v2, 0x2

    if-ne v0, v2, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :cond_1
    :goto_0
    return v1
.end method

.method public c()Z
    .locals 6

    iget v0, p0, Lcom/taobao/accs/messenger/d;->b:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 66
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-wide v4, p0, Lcom/taobao/accs/messenger/d;->f:J

    sub-long/2addr v2, v4

    const-wide/16 v4, 0x1388

    cmp-long v0, v2, v4

    if-lez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .locals 0

    if-nez p2, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/messenger/d;->a:Landroid/content/Context;

    .line 34
    invoke-virtual {p1, p0}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V

    const/4 p1, 0x0

    iput p1, p0, Lcom/taobao/accs/messenger/d;->b:I

    return-void

    .line 38
    :cond_0
    new-instance p1, Landroid/os/Messenger;

    invoke-direct {p1, p2}, Landroid/os/Messenger;-><init>(Landroid/os/IBinder;)V

    iput-object p1, p0, Lcom/taobao/accs/messenger/d;->c:Landroid/os/Messenger;

    const/4 p1, 0x2

    iput p1, p0, Lcom/taobao/accs/messenger/d;->b:I

    return-void
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .locals 1

    iget-object p1, p0, Lcom/taobao/accs/messenger/d;->e:Lcom/taobao/accs/messenger/a;

    iget-object v0, p0, Lcom/taobao/accs/messenger/d;->d:Ljava/lang/String;

    .line 44
    invoke-virtual {p1, v0, p0}, Lcom/taobao/accs/messenger/a;->a(Ljava/lang/String;Lcom/taobao/accs/messenger/d;)V

    const/4 p1, 0x0

    iput p1, p0, Lcom/taobao/accs/messenger/d;->b:I

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/taobao/accs/messenger/d;->c:Landroid/os/Messenger;

    return-void
.end method
