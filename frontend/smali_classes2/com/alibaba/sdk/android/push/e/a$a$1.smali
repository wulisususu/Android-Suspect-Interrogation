.class Lcom/alibaba/sdk/android/push/e/a$a$1;
.super Landroid/os/Handler;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/push/e/a$a;->onLooperPrepared()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/push/e/a$a;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/push/e/a$a;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$a$1;->a:Lcom/alibaba/sdk/android/push/e/a$a;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 6

    iget v0, p1, Landroid/os/Message;->what:I

    const/4 v1, 0x2

    const/4 v2, 0x1

    if-eq v0, v2, :cond_0

    iget v0, p1, Landroid/os/Message;->what:I

    if-ne v0, v1, :cond_3

    :cond_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/a;->g()Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "Looping handleMessage: "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v5, p1, Landroid/os/Message;->what:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    iget p1, p1, Landroid/os/Message;->what:I

    if-ne p1, v2, :cond_1

    invoke-virtual {p0, v1}, Lcom/alibaba/sdk/android/push/e/a$a$1;->removeMessages(I)V

    :cond_1
    iget-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$a$1;->a:Lcom/alibaba/sdk/android/push/e/a$a;

    iget-object p1, p1, Lcom/alibaba/sdk/android/push/e/a$a;->f:Lcom/alibaba/sdk/android/push/e/a;

    iget-boolean p1, p1, Lcom/alibaba/sdk/android/push/e/a;->d:Z

    if-nez p1, :cond_3

    iget-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$a$1;->a:Lcom/alibaba/sdk/android/push/e/a$a;

    invoke-static {p1, v0}, Lcom/alibaba/sdk/android/push/e/a$a;->a(Lcom/alibaba/sdk/android/push/e/a$a;Ljava/lang/Object;)Lcom/alibaba/sdk/android/push/e/e;

    move-result-object p1

    if-eqz p1, :cond_3

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/e/a$a$1;->a:Lcom/alibaba/sdk/android/push/e/a$a;

    invoke-virtual {v1, p1}, Lcom/alibaba/sdk/android/push/e/a$a;->a(Lcom/alibaba/sdk/android/push/e/e;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/e/a$a$1;->a:Lcom/alibaba/sdk/android/push/e/a$a;

    iget v1, v1, Lcom/alibaba/sdk/android/push/e/a$a;->d:I

    if-gt v1, v2, :cond_3

    :cond_2
    iget-object v1, p0, Lcom/alibaba/sdk/android/push/e/a$a$1;->a:Lcom/alibaba/sdk/android/push/e/a$a;

    iget-object v1, v1, Lcom/alibaba/sdk/android/push/e/a$a;->b:Landroid/os/Handler;

    new-instance v2, Lcom/alibaba/sdk/android/push/e/a$a$1$1;

    invoke-direct {v2, p0, v0, p1}, Lcom/alibaba/sdk/android/push/e/a$a$1$1;-><init>(Lcom/alibaba/sdk/android/push/e/a$a$1;Ljava/lang/Object;Lcom/alibaba/sdk/android/push/e/e;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_3
    return-void
.end method
