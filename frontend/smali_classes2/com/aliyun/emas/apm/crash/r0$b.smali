.class final Lcom/aliyun/emas/apm/crash/r0$b;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/r0;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "b"
.end annotation


# instance fields
.field private final a:Lcom/aliyun/emas/apm/crash/q;

.field private final b:Lcom/google/android/gms/tasks/TaskCompletionSource;

.field final synthetic c:Lcom/aliyun/emas/apm/crash/r0;


# direct methods
.method private constructor <init>(Lcom/aliyun/emas/apm/crash/r0;Lcom/aliyun/emas/apm/crash/q;Lcom/google/android/gms/tasks/TaskCompletionSource;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/r0$b;->c:Lcom/aliyun/emas/apm/crash/r0;

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/r0$b;->a:Lcom/aliyun/emas/apm/crash/q;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/r0$b;->b:Lcom/google/android/gms/tasks/TaskCompletionSource;

    return-void
.end method

.method synthetic constructor <init>(Lcom/aliyun/emas/apm/crash/r0;Lcom/aliyun/emas/apm/crash/q;Lcom/google/android/gms/tasks/TaskCompletionSource;Lcom/aliyun/emas/apm/crash/r0$a;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2, p3}, Lcom/aliyun/emas/apm/crash/r0$b;-><init>(Lcom/aliyun/emas/apm/crash/r0;Lcom/aliyun/emas/apm/crash/q;Lcom/google/android/gms/tasks/TaskCompletionSource;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/r0$b;->c:Lcom/aliyun/emas/apm/crash/r0;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/r0$b;->a:Lcom/aliyun/emas/apm/crash/q;

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/r0$b;->b:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 1
    invoke-static {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/r0;->a(Lcom/aliyun/emas/apm/crash/r0;Lcom/aliyun/emas/apm/crash/q;Lcom/google/android/gms/tasks/TaskCompletionSource;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/r0$b;->c:Lcom/aliyun/emas/apm/crash/r0;

    .line 2
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/r0;->a(Lcom/aliyun/emas/apm/crash/r0;)Lcom/aliyun/emas/apm/crash/m0;

    move-result-object v0

    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/m0;->c()V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/r0$b;->c:Lcom/aliyun/emas/apm/crash/r0;

    .line 5
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/r0;->b(Lcom/aliyun/emas/apm/crash/r0;)D

    move-result-wide v0

    .line 6
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Delay for: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    const-wide v5, 0x408f400000000000L    # 1000.0

    div-double v5, v0, v5

    .line 9
    invoke-static {v5, v6}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    const-string v6, "%.2f"

    invoke-static {v4, v6, v5}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " s for report: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/aliyun/emas/apm/crash/r0$b;->a:Lcom/aliyun/emas/apm/crash/q;

    .line 11
    invoke-virtual {v4}, Lcom/aliyun/emas/apm/crash/q;->c()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 12
    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    .line 17
    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/crash/r0;->a(D)V

    return-void
.end method
