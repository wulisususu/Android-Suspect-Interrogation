.class Lcom/alibaba/sdk/android/push/a/a$3$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/alibaba/sdk/android/push/CommonCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/push/a/a$3$1;->onSuccess()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/push/a/a$3$1;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/push/a/a$3$1;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/a/a$3$1$1;->a:Lcom/alibaba/sdk/android/push/a/a$3$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailed(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/a/a$3$1$1;->a:Lcom/alibaba/sdk/android/push/a/a$3$1;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/a/a$3$1;->a:Lcom/alibaba/sdk/android/push/a/a$3;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/a/a$3;->b:Lcom/alibaba/sdk/android/push/a/a;

    invoke-static {v0}, Lcom/alibaba/sdk/android/push/a/a;->a(Lcom/alibaba/sdk/android/push/a/a;)Landroid/content/Context;

    move-result-object v0

    new-instance v1, Lcom/alibaba/sdk/android/push/a/a$3$1$1$1;

    invoke-direct {v1, p0, p1, p2}, Lcom/alibaba/sdk/android/push/a/a$3$1$1$1;-><init>(Lcom/alibaba/sdk/android/push/a/a$3$1$1;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0, v1}, Lcom/taobao/agoo/TaobaoRegister;->unbindAgoo(Landroid/content/Context;Lcom/taobao/agoo/ICallback;)V

    return-void
.end method

.method public onSuccess(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/a/a$3$1$1;->a:Lcom/alibaba/sdk/android/push/a/a$3$1;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/a/a$3$1;->a:Lcom/alibaba/sdk/android/push/a/a$3;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/a/a$3;->a:Lcom/alibaba/sdk/android/push/CommonCallback;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/a/a$3$1$1;->a:Lcom/alibaba/sdk/android/push/a/a$3$1;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/a/a$3$1;->a:Lcom/alibaba/sdk/android/push/a/a$3;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/a/a$3;->a:Lcom/alibaba/sdk/android/push/CommonCallback;

    invoke-interface {v0, p1}, Lcom/alibaba/sdk/android/push/CommonCallback;->onSuccess(Ljava/lang/String;)V

    :cond_0
    return-void
.end method
