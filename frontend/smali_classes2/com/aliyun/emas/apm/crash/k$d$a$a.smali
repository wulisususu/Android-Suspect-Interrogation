.class Lcom/aliyun/emas/apm/crash/k$d$a$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/android/gms/tasks/SuccessContinuation;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/k$d$a;->a()Lcom/google/android/gms/tasks/Task;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/concurrent/Executor;

.field final synthetic b:Lcom/aliyun/emas/apm/crash/k$d$a;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/k$d$a;Ljava/util/concurrent/Executor;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/k$d$a$a;->b:Lcom/aliyun/emas/apm/crash/k$d$a;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/k$d$a$a;->a:Ljava/util/concurrent/Executor;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/aliyun/emas/apm/settings/Settings;)Lcom/google/android/gms/tasks/Task;
    .locals 2

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    .line 1
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/settings/Settings;->isCrashEnabled()Z

    move-result p1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/k$d$a$a;->b:Lcom/aliyun/emas/apm/crash/k$d$a;

    .line 6
    iget-object p1, p1, Lcom/aliyun/emas/apm/crash/k$d$a;->b:Lcom/aliyun/emas/apm/crash/k$d;

    iget-object p1, p1, Lcom/aliyun/emas/apm/crash/k$d;->b:Lcom/aliyun/emas/apm/crash/k;

    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/k;->c(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/u0;

    move-result-object p1

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/k$d$a$a;->a:Ljava/util/concurrent/Executor;

    invoke-virtual {p1, v1}, Lcom/aliyun/emas/apm/crash/u0;->a(Ljava/util/concurrent/Executor;)Lcom/google/android/gms/tasks/Task;

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/k$d$a$a;->b:Lcom/aliyun/emas/apm/crash/k$d$a;

    .line 7
    iget-object p1, p1, Lcom/aliyun/emas/apm/crash/k$d$a;->b:Lcom/aliyun/emas/apm/crash/k$d;

    iget-object p1, p1, Lcom/aliyun/emas/apm/crash/k$d;->b:Lcom/aliyun/emas/apm/crash/k;

    iget-object p1, p1, Lcom/aliyun/emas/apm/crash/k;->q:Lcom/google/android/gms/tasks/TaskCompletionSource;

    invoke-virtual {p1, v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    .line 9
    invoke-static {v0}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1

    .line 10
    :cond_1
    :goto_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string v1, "Cannot send cached reports as crash isn\'t enabled"

    invoke-virtual {p1, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;)V

    .line 11
    invoke-static {v0}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic then(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;
    .locals 0

    .line 1
    check-cast p1, Lcom/aliyun/emas/apm/settings/Settings;

    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/crash/k$d$a$a;->a(Lcom/aliyun/emas/apm/settings/Settings;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method
