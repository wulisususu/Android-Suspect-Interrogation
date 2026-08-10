.class Lcom/alibaba/sdk/android/push/e/a$2;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/alibaba/sdk/android/push/e/c;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/push/e/a;->a(Lcom/alibaba/sdk/android/push/CommonCallback;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/alibaba/sdk/android/push/e/c<",
        "Lcom/alibaba/sdk/android/push/e/d;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/push/CommonCallback;

.field final synthetic b:Lcom/alibaba/sdk/android/push/e/a;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/push/e/a;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$2;->b:Lcom/alibaba/sdk/android/push/e/a;

    iput-object p2, p0, Lcom/alibaba/sdk/android/push/e/a$2;->a:Lcom/alibaba/sdk/android/push/CommonCallback;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/alibaba/sdk/android/push/e/d;Lcom/alibaba/sdk/android/push/e/e;)V
    .locals 3

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/push/e/e;->a()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p1

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lcom/alibaba/sdk/android/push/common/global/c;->a:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    const-class p1, Lcom/alibaba/sdk/android/push/e/a;

    monitor-enter p1

    :try_start_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/push/e/a$2;->b:Lcom/alibaba/sdk/android/push/e/a;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/alibaba/sdk/android/push/e/a;->d:Z

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/e/a$2;->b:Lcom/alibaba/sdk/android/push/e/a;

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/alibaba/sdk/android/push/e/a;->b:Z

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/e/a$2;->b:Lcom/alibaba/sdk/android/push/e/a;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/e/a;->a:Lcom/alibaba/sdk/android/push/e/a$a;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/push/e/a$a;->b()V

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/e/a$2;->b:Lcom/alibaba/sdk/android/push/e/a;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/e/a;->a:Lcom/alibaba/sdk/android/push/e/a$a;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/push/e/a$a;->quit()Z

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/a/a;->a()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/push/common/util/c;->a(Landroid/content/Context;)Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    :try_start_1
    iget-object v1, p0, Lcom/alibaba/sdk/android/push/e/a$2;->b:Lcom/alibaba/sdk/android/push/e/a;

    invoke-static {v1}, Lcom/alibaba/sdk/android/push/e/a;->a(Lcom/alibaba/sdk/android/push/e/a;)Lcom/alibaba/sdk/android/push/e/a$b;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catch_0
    move-exception v0

    :try_start_2
    invoke-static {}, Lcom/alibaba/sdk/android/push/e/a;->g()Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    move-result-object v1

    const-string v2, "Fail to unregister broad"

    invoke-virtual {v1, v2, v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_0
    :goto_0
    monitor-exit p1

    goto :goto_1

    :catchall_0
    move-exception p2

    monitor-exit p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p2

    :cond_1
    :goto_1
    iget-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$2;->a:Lcom/alibaba/sdk/android/push/CommonCallback;

    invoke-static {p1, p2}, Lcom/alibaba/sdk/android/push/e/b;->a(Lcom/alibaba/sdk/android/push/CommonCallback;Lcom/alibaba/sdk/android/push/e/e;)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;Lcom/alibaba/sdk/android/push/e/e;)V
    .locals 0

    check-cast p1, Lcom/alibaba/sdk/android/push/e/d;

    invoke-virtual {p0, p1, p2}, Lcom/alibaba/sdk/android/push/e/a$2;->a(Lcom/alibaba/sdk/android/push/e/d;Lcom/alibaba/sdk/android/push/e/e;)V

    return-void
.end method
