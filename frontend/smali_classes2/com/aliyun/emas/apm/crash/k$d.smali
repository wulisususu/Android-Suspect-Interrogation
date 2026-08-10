.class Lcom/aliyun/emas/apm/crash/k$d;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/android/gms/tasks/SuccessContinuation;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/k;->a(Lcom/google/android/gms/tasks/Task;)Lcom/google/android/gms/tasks/Task;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/google/android/gms/tasks/Task;

.field final synthetic b:Lcom/aliyun/emas/apm/crash/k;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/k;Lcom/google/android/gms/tasks/Task;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/k$d;->b:Lcom/aliyun/emas/apm/crash/k;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/k$d;->a:Lcom/google/android/gms/tasks/Task;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/Boolean;)Lcom/google/android/gms/tasks/Task;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k$d;->b:Lcom/aliyun/emas/apm/crash/k;

    .line 1
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/k;->e(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/j;

    move-result-object v0

    new-instance v1, Lcom/aliyun/emas/apm/crash/k$d$a;

    invoke-direct {v1, p0, p1}, Lcom/aliyun/emas/apm/crash/k$d$a;-><init>(Lcom/aliyun/emas/apm/crash/k$d;Ljava/lang/Boolean;)V

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/j;->c(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic then(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;
    .locals 0

    .line 1
    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/crash/k$d;->a(Ljava/lang/Boolean;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method
