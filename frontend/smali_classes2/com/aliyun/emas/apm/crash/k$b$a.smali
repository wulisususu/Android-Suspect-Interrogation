.class Lcom/aliyun/emas/apm/crash/k$b$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/android/gms/tasks/SuccessContinuation;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/k$b;->a()Lcom/google/android/gms/tasks/Task;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/concurrent/Executor;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lcom/aliyun/emas/apm/crash/k$b;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/k$b;Ljava/util/concurrent/Executor;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/k$b$a;->c:Lcom/aliyun/emas/apm/crash/k$b;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/k$b$a;->a:Ljava/util/concurrent/Executor;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/k$b$a;->b:Ljava/lang/String;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/aliyun/emas/apm/settings/Settings;)Lcom/google/android/gms/tasks/Task;
    .locals 4

    const/4 v0, 0x0

    if-eqz p1, :cond_2

    .line 1
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/settings/Settings;->isCrashEnabled()Z

    move-result p1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x1

    new-array p1, p1, [Lcom/google/android/gms/tasks/Task;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/k$b$a;->c:Lcom/aliyun/emas/apm/crash/k$b;

    .line 6
    iget-object v1, v1, Lcom/aliyun/emas/apm/crash/k$b;->g:Lcom/aliyun/emas/apm/crash/k;

    .line 7
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/k;->c(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/u0;

    move-result-object v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/k$b$a;->a:Ljava/util/concurrent/Executor;

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/k$b$a;->c:Lcom/aliyun/emas/apm/crash/k$b;

    .line 8
    iget-boolean v3, v3, Lcom/aliyun/emas/apm/crash/k$b;->e:Z

    if-eqz v3, :cond_1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k$b$a;->b:Ljava/lang/String;

    .line 9
    :cond_1
    invoke-virtual {v1, v2, v0}, Lcom/aliyun/emas/apm/crash/u0;->a(Ljava/util/concurrent/Executor;Ljava/lang/String;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    const/4 v1, 0x0

    aput-object v0, p1, v1

    .line 10
    invoke-static {p1}, Lcom/google/android/gms/tasks/Tasks;->whenAll([Lcom/google/android/gms/tasks/Task;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1

    .line 11
    :cond_2
    :goto_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string v1, "Cannot send reports at crash time as crash isn\'t enabled"

    invoke-virtual {p1, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;)V

    .line 12
    invoke-static {v0}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic then(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;
    .locals 0

    .line 1
    check-cast p1, Lcom/aliyun/emas/apm/settings/Settings;

    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/crash/k$b$a;->a(Lcom/aliyun/emas/apm/settings/Settings;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method
