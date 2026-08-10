.class Lcom/aliyun/emas/apm/crash/k$d$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/k$d;->a(Ljava/lang/Boolean;)Lcom/google/android/gms/tasks/Task;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/Boolean;

.field final synthetic b:Lcom/aliyun/emas/apm/crash/k$d;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/k$d;Ljava/lang/Boolean;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/k$d$a;->b:Lcom/aliyun/emas/apm/crash/k$d;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/k$d$a;->a:Ljava/lang/Boolean;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()Lcom/google/android/gms/tasks/Task;
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k$d$a;->a:Ljava/lang/Boolean;

    .line 1
    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-nez v0, :cond_0

    .line 2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    const-string v1, "Deleting cached crash reports..."

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k$d$a;->b:Lcom/aliyun/emas/apm/crash/k$d;

    .line 3
    iget-object v0, v0, Lcom/aliyun/emas/apm/crash/k$d;->b:Lcom/aliyun/emas/apm/crash/k;

    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/k;->c(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/u0;

    move-result-object v0

    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/u0;->c()V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k$d$a;->b:Lcom/aliyun/emas/apm/crash/k$d;

    .line 4
    iget-object v0, v0, Lcom/aliyun/emas/apm/crash/k$d;->b:Lcom/aliyun/emas/apm/crash/k;

    iget-object v0, v0, Lcom/aliyun/emas/apm/crash/k;->q:Lcom/google/android/gms/tasks/TaskCompletionSource;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    .line 5
    invoke-static {v1}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    return-object v0

    .line 8
    :cond_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    const-string v1, "Sending cached crash reports..."

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k$d$a;->a:Ljava/lang/Boolean;

    .line 11
    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/k$d$a;->b:Lcom/aliyun/emas/apm/crash/k$d;

    .line 15
    iget-object v1, v1, Lcom/aliyun/emas/apm/crash/k$d;->b:Lcom/aliyun/emas/apm/crash/k;

    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/k;->d(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/u;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/aliyun/emas/apm/crash/u;->a(Z)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k$d$a;->b:Lcom/aliyun/emas/apm/crash/k$d;

    .line 17
    iget-object v0, v0, Lcom/aliyun/emas/apm/crash/k$d;->b:Lcom/aliyun/emas/apm/crash/k;

    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/k;->e(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/j;

    move-result-object v0

    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/j;->b()Ljava/util/concurrent/Executor;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/k$d$a;->b:Lcom/aliyun/emas/apm/crash/k$d;

    .line 19
    iget-object v1, v1, Lcom/aliyun/emas/apm/crash/k$d;->a:Lcom/google/android/gms/tasks/Task;

    new-instance v2, Lcom/aliyun/emas/apm/crash/k$d$a$a;

    invoke-direct {v2, p0, v0}, Lcom/aliyun/emas/apm/crash/k$d$a$a;-><init>(Lcom/aliyun/emas/apm/crash/k$d$a;Ljava/util/concurrent/Executor;)V

    invoke-virtual {v1, v0, v2}, Lcom/google/android/gms/tasks/Task;->onSuccessTask(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/SuccessContinuation;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic call()Ljava/lang/Object;
    .locals 1

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/k$d$a;->a()Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    return-object v0
.end method
