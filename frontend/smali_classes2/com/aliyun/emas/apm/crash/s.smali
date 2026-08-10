.class Lcom/aliyun/emas/apm/crash/s;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Thread$UncaughtExceptionHandler;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/s$a;
    }
.end annotation


# instance fields
.field private final a:Lcom/aliyun/emas/apm/crash/s$a;

.field private final b:Lcom/aliyun/emas/apm/settings/SettingProvider;

.field private final c:Lcom/aliyun/emas/apm/crash/x0;

.field private final d:Ljava/lang/Thread$UncaughtExceptionHandler;

.field private final e:Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

.field private final f:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method public constructor <init>(Lcom/aliyun/emas/apm/crash/s$a;Lcom/aliyun/emas/apm/settings/SettingProvider;Lcom/aliyun/emas/apm/crash/x0;Ljava/lang/Thread$UncaughtExceptionHandler;Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/s;->a:Lcom/aliyun/emas/apm/crash/s$a;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/s;->b:Lcom/aliyun/emas/apm/settings/SettingProvider;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/s;->c:Lcom/aliyun/emas/apm/crash/x0;

    iput-object p4, p0, Lcom/aliyun/emas/apm/crash/s;->d:Ljava/lang/Thread$UncaughtExceptionHandler;

    .line 6
    new-instance p1, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 p2, 0x0

    invoke-direct {p1, p2}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/s;->f:Ljava/util/concurrent/atomic/AtomicBoolean;

    iput-object p5, p0, Lcom/aliyun/emas/apm/crash/s;->e:Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    return-void
.end method

.method private a(Ljava/lang/Thread;Ljava/lang/Throwable;)Z
    .locals 1

    const/4 v0, 0x0

    if-nez p1, :cond_0

    .line 2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string p2, "Crashlytics will not record uncaught exception; null thread"

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;)V

    return v0

    :cond_0
    if-nez p2, :cond_1

    .line 6
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string p2, "Crashlytics will not record uncaught exception; null throwable"

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;)V

    return v0

    :cond_1
    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/s;->e:Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    .line 11
    invoke-interface {p1}, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;->hasCrashDataForCurrentSession()Z

    move-result p1

    if-eqz p1, :cond_2

    .line 12
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string p2, "Crashlytics will not record uncaught exception; native crash exists for session."

    .line 13
    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    return v0

    :cond_2
    const/4 p1, 0x1

    return p1
.end method


# virtual methods
.method a()Z
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/s;->f:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    return v0
.end method

.method public uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V
    .locals 5

    const-string v0, "Completed exception processing. Invoking default exception handler."

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/s;->f:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v2, 0x1

    .line 1
    invoke-virtual {v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    const/4 v1, 0x0

    .line 3
    :try_start_0
    invoke-direct {p0, p1, p2}, Lcom/aliyun/emas/apm/crash/s;->a(Ljava/lang/Thread;Ljava/lang/Throwable;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/s;->a:Lcom/aliyun/emas/apm/crash/s$a;

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/s;->b:Lcom/aliyun/emas/apm/settings/SettingProvider;

    iget-object v4, p0, Lcom/aliyun/emas/apm/crash/s;->c:Lcom/aliyun/emas/apm/crash/x0;

    .line 4
    invoke-interface {v2, v3, v4, p1, p2}, Lcom/aliyun/emas/apm/crash/s$a;->a(Lcom/aliyun/emas/apm/settings/SettingProvider;Lcom/aliyun/emas/apm/crash/x0;Ljava/lang/Thread;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 6
    :cond_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v2

    const-string v3, "Uncaught exception will not be recorded by Crashlytics."

    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 11
    :goto_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v2

    invoke-virtual {v2, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/s;->d:Ljava/lang/Thread$UncaughtExceptionHandler;

    .line 12
    invoke-interface {v0, p1, p2}, Ljava/lang/Thread$UncaughtExceptionHandler;->uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/s;->f:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 13
    invoke-virtual {p1, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    goto :goto_1

    :catchall_0
    move-exception v2

    goto :goto_2

    :catch_0
    move-exception v2

    .line 14
    :try_start_1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v3

    const-string v4, "An error occurred in the uncaught exception handler"

    invoke-virtual {v3, v4, v2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 16
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v2

    invoke-virtual {v2, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/s;->d:Ljava/lang/Thread$UncaughtExceptionHandler;

    .line 17
    invoke-interface {v0, p1, p2}, Ljava/lang/Thread$UncaughtExceptionHandler;->uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/s;->f:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 18
    invoke-virtual {p1, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    :goto_1
    return-void

    .line 19
    :goto_2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v3

    invoke-virtual {v3, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/s;->d:Ljava/lang/Thread$UncaughtExceptionHandler;

    .line 20
    invoke-interface {v0, p1, p2}, Ljava/lang/Thread$UncaughtExceptionHandler;->uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/s;->f:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 21
    invoke-virtual {p1, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 22
    throw v2
.end method
