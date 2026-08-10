.class Lcom/alibaba/sdk/android/push/e/a$b;
.super Landroid/content/BroadcastReceiver;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/sdk/android/push/e/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/push/e/a;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/push/e/a;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$b;->a:Lcom/alibaba/sdk/android/push/e/a;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2

    if-eqz p2, :cond_2

    const-string v0, "android.net.conn.CONNECTIVITY_CHANGE"

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string p1, "noConnectivity"

    const/4 v0, 0x0

    invoke-virtual {p2, p1, v0}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$b;->a:Lcom/alibaba/sdk/android/push/e/a;

    iget-boolean p1, p1, Lcom/alibaba/sdk/android/push/e/a;->d:Z

    if-nez p1, :cond_2

    iget-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$b;->a:Lcom/alibaba/sdk/android/push/e/a;

    iget-boolean p1, p1, Lcom/alibaba/sdk/android/push/e/a;->b:Z

    if-eqz p1, :cond_2

    :goto_0
    iget-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$b;->a:Lcom/alibaba/sdk/android/push/e/a;

    iget-object p1, p1, Lcom/alibaba/sdk/android/push/e/a;->a:Lcom/alibaba/sdk/android/push/e/a$a;

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/push/e/a$a;->a()V

    goto :goto_1

    :cond_0
    invoke-static {}, Lcom/alibaba/sdk/android/push/e/a;->g()Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    move-result-object p1

    const-string p2, "Network has lost"

    invoke-virtual {p1, p2}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    const-string v0, "android.intent.action.USER_PRESENT"

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_2

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/common/util/a;->a(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$b;->a:Lcom/alibaba/sdk/android/push/e/a;

    iget-boolean p1, p1, Lcom/alibaba/sdk/android/push/e/a;->d:Z

    if-nez p1, :cond_2

    iget-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$b;->a:Lcom/alibaba/sdk/android/push/e/a;

    iget-boolean p1, p1, Lcom/alibaba/sdk/android/push/e/a;->b:Z

    if-eqz p1, :cond_2

    goto :goto_0

    :cond_2
    :goto_1
    return-void
.end method
