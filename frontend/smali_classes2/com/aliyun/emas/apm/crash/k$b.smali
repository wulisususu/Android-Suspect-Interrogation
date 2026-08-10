.class Lcom/aliyun/emas/apm/crash/k$b;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/k;->a(Lcom/aliyun/emas/apm/settings/SettingProvider;Lcom/aliyun/emas/apm/crash/x0;Ljava/lang/Thread;Ljava/lang/Throwable;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/Throwable;

.field final synthetic b:Ljava/lang/Thread;

.field final synthetic c:J

.field final synthetic d:Lcom/aliyun/emas/apm/crash/x0;

.field final synthetic e:Z

.field final synthetic f:Lcom/aliyun/emas/apm/settings/SettingProvider;

.field final synthetic g:Lcom/aliyun/emas/apm/crash/k;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/k;Ljava/lang/Throwable;Ljava/lang/Thread;JLcom/aliyun/emas/apm/crash/x0;ZLcom/aliyun/emas/apm/settings/SettingProvider;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/k$b;->g:Lcom/aliyun/emas/apm/crash/k;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/k$b;->a:Ljava/lang/Throwable;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/k$b;->b:Ljava/lang/Thread;

    iput-wide p4, p0, Lcom/aliyun/emas/apm/crash/k$b;->c:J

    iput-object p6, p0, Lcom/aliyun/emas/apm/crash/k$b;->d:Lcom/aliyun/emas/apm/crash/x0;

    iput-boolean p7, p0, Lcom/aliyun/emas/apm/crash/k$b;->e:Z

    iput-object p8, p0, Lcom/aliyun/emas/apm/crash/k$b;->f:Lcom/aliyun/emas/apm/settings/SettingProvider;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()Lcom/google/android/gms/tasks/Task;
    .locals 8

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k$b;->g:Lcom/aliyun/emas/apm/crash/k;

    .line 1
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/k;->a(Lcom/aliyun/emas/apm/crash/k;)Ljava/lang/String;

    move-result-object v0

    const/4 v7, 0x0

    if-nez v0, :cond_0

    .line 3
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    const-string v1, "Tried to write a fatal exception while no session was open."

    .line 4
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;)V

    .line 5
    invoke-static {v7}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    return-object v0

    :cond_0
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/k$b;->g:Lcom/aliyun/emas/apm/crash/k;

    .line 9
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/k;->b(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/m;

    move-result-object v1

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/m;->a()Z

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/k$b;->g:Lcom/aliyun/emas/apm/crash/k;

    .line 11
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/k;->c(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/u0;

    move-result-object v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/k$b;->a:Ljava/lang/Throwable;

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/k$b;->b:Ljava/lang/Thread;

    iget-wide v5, p0, Lcom/aliyun/emas/apm/crash/k$b;->c:J

    move-object v4, v0

    invoke-virtual/range {v1 .. v6}, Lcom/aliyun/emas/apm/crash/u0;->a(Ljava/lang/Throwable;Ljava/lang/Thread;Ljava/lang/String;J)V

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/k$b;->g:Lcom/aliyun/emas/apm/crash/k;

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/k$b;->d:Lcom/aliyun/emas/apm/crash/x0;

    .line 14
    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/k;->a(Lcom/aliyun/emas/apm/crash/x0;)V

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/k$b;->g:Lcom/aliyun/emas/apm/crash/k;

    .line 15
    new-instance v2, Lcom/aliyun/emas/apm/crash/h;

    invoke-direct {v2}, Lcom/aliyun/emas/apm/crash/h;-><init>()V

    invoke-virtual {v2}, Lcom/aliyun/emas/apm/crash/h;->a()Ljava/lang/String;

    move-result-object v2

    iget-boolean v3, p0, Lcom/aliyun/emas/apm/crash/k$b;->e:Z

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lcom/aliyun/emas/apm/crash/k;->a(Lcom/aliyun/emas/apm/crash/k;Ljava/lang/String;Ljava/lang/Boolean;)V

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/k$b;->g:Lcom/aliyun/emas/apm/crash/k;

    .line 19
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/k;->d(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/u;

    move-result-object v1

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/u;->b()Z

    move-result v1

    if-nez v1, :cond_1

    .line 20
    invoke-static {v7}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    return-object v0

    :cond_1
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/k$b;->g:Lcom/aliyun/emas/apm/crash/k;

    .line 23
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/k;->e(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/j;

    move-result-object v1

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/j;->b()Ljava/util/concurrent/Executor;

    move-result-object v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/k$b;->f:Lcom/aliyun/emas/apm/settings/SettingProvider;

    .line 26
    invoke-interface {v2}, Lcom/aliyun/emas/apm/settings/SettingProvider;->getSettingsAsync()Lcom/google/android/gms/tasks/Task;

    move-result-object v2

    new-instance v3, Lcom/aliyun/emas/apm/crash/k$b$a;

    invoke-direct {v3, p0, v1, v0}, Lcom/aliyun/emas/apm/crash/k$b$a;-><init>(Lcom/aliyun/emas/apm/crash/k$b;Ljava/util/concurrent/Executor;Ljava/lang/String;)V

    .line 27
    invoke-virtual {v2, v1, v3}, Lcom/google/android/gms/tasks/Task;->onSuccessTask(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/SuccessContinuation;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic call()Ljava/lang/Object;
    .locals 1

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/k$b;->a()Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    return-object v0
.end method
