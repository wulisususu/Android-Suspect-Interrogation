.class public Lcom/aliyun/ams/emas/push/NotificationActivity;
.super Landroid/app/Activity;
.source "Taobao"


# static fields
.field public static final TAG:Ljava/lang/String; = "MPS:NotificationActivity"


# instance fields
.field a:Lcom/aliyun/ams/emas/push/notification/f;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 13
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 15
    new-instance v0, Lcom/aliyun/ams/emas/push/notification/f;

    invoke-direct {v0}, Lcom/aliyun/ams/emas/push/notification/f;-><init>()V

    iput-object v0, p0, Lcom/aliyun/ams/emas/push/NotificationActivity;->a:Lcom/aliyun/ams/emas/push/notification/f;

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4

    .line 20
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 22
    invoke-virtual {p0}, Lcom/aliyun/ams/emas/push/NotificationActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 24
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 26
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, " onCreate begin...action="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "MPS:NotificationActivity"

    invoke-static {v3, v1, v2}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 27
    sget-object v1, Lcom/aliyun/ams/emas/push/h;->a:Ljava/lang/String;

    invoke-static {v0, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/ams/emas/push/NotificationActivity;->a:Lcom/aliyun/ams/emas/push/notification/f;

    .line 28
    invoke-virtual {p0}, Lcom/aliyun/ams/emas/push/NotificationActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v0, p1, v1, v2}, Lcom/aliyun/ams/emas/push/notification/f;->a(Landroid/content/Intent;Landroid/content/Context;I)I

    .line 32
    :cond_0
    invoke-virtual {p0}, Lcom/aliyun/ams/emas/push/NotificationActivity;->finish()V

    return-void
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 4

    .line 37
    invoke-super {p0, p1}, Landroid/app/Activity;->onNewIntent(Landroid/content/Intent;)V

    if-eqz p1, :cond_0

    .line 39
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 41
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, " onNewIntent begin...action="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "MPS:NotificationActivity"

    invoke-static {v3, v1, v2}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 42
    sget-object v1, Lcom/aliyun/ams/emas/push/h;->a:Ljava/lang/String;

    invoke-static {v0, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/ams/emas/push/NotificationActivity;->a:Lcom/aliyun/ams/emas/push/notification/f;

    .line 43
    invoke-virtual {p0}, Lcom/aliyun/ams/emas/push/NotificationActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v0, p1, v1, v2}, Lcom/aliyun/ams/emas/push/notification/f;->a(Landroid/content/Intent;Landroid/content/Context;I)I

    .line 46
    :cond_0
    invoke-virtual {p0}, Lcom/aliyun/ams/emas/push/NotificationActivity;->finish()V

    return-void
.end method
