.class public Lcom/aliyun/emas/apm/crash/ndk/a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/ndk/a$a;
    }
.end annotation


# static fields
.field public static e:Lcom/aliyun/emas/apm/crash/ndk/a;


# instance fields
.field public final a:Lcom/aliyun/emas/apm/crash/ndk/b;

.field public b:Z

.field public c:Ljava/lang/String;

.field public d:Lcom/aliyun/emas/apm/crash/ndk/a$a;


# direct methods
.method public constructor <init>(Lcom/aliyun/emas/apm/crash/ndk/b;Z)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/ndk/a;->a:Lcom/aliyun/emas/apm/crash/ndk/b;

    iput-boolean p2, p0, Lcom/aliyun/emas/apm/crash/ndk/a;->b:Z

    return-void
.end method

.method public static a(Landroid/content/Context;Z)Lcom/aliyun/emas/apm/crash/ndk/a;
    .locals 3

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/ndk/b;

    new-instance v1, Lcom/aliyun/emas/apm/crash/ndk/JniNativeApi;

    invoke-direct {v1, p0}, Lcom/aliyun/emas/apm/crash/ndk/JniNativeApi;-><init>(Landroid/content/Context;)V

    new-instance v2, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    invoke-direct {v2, p0}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;-><init>(Landroid/content/Context;)V

    invoke-direct {v0, p0, v1, v2}, Lcom/aliyun/emas/apm/crash/ndk/b;-><init>(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/ndk/c;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;)V

    .line 4
    new-instance p0, Lcom/aliyun/emas/apm/crash/ndk/a;

    invoke-direct {p0, v0, p1}, Lcom/aliyun/emas/apm/crash/ndk/a;-><init>(Lcom/aliyun/emas/apm/crash/ndk/b;Z)V

    sput-object p0, Lcom/aliyun/emas/apm/crash/ndk/a;->e:Lcom/aliyun/emas/apm/crash/ndk/a;

    return-object p0
.end method


# virtual methods
.method public final synthetic a(Ljava/lang/String;)V
    .locals 3

    .line 5
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Initializing native session: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ndk/a;->a:Lcom/aliyun/emas/apm/crash/ndk/b;

    .line 6
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/ndk/b;->e(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 7
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Failed to initialize ApmCrashAnalysis NDK for session "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public getSessionFileProvider(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;
    .locals 2

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/ndk/e;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/ndk/a;->a:Lcom/aliyun/emas/apm/crash/ndk/b;

    invoke-virtual {v1, p1}, Lcom/aliyun/emas/apm/crash/ndk/b;->b(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/ndk/d;

    move-result-object p1

    invoke-direct {v0, p1}, Lcom/aliyun/emas/apm/crash/ndk/e;-><init>(Lcom/aliyun/emas/apm/crash/ndk/d;)V

    return-object v0
.end method

.method public hasCrashDataForCurrentSession()Z
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ndk/a;->c:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 1
    invoke-virtual {p0, v0}, Lcom/aliyun/emas/apm/crash/ndk/a;->hasCrashDataForSession(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hasCrashDataForSession(Ljava/lang/String;)Z
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ndk/a;->a:Lcom/aliyun/emas/apm/crash/ndk/b;

    .line 1
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/ndk/b;->d(Ljava/lang/String;)Z

    move-result p1

    return p1
.end method

.method public declared-synchronized prepareNativeSession(Ljava/lang/String;)V
    .locals 1

    monitor-enter p0

    :try_start_0
    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/ndk/a;->c:Ljava/lang/String;

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/crash/ndk/a$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0, p1}, Lcom/aliyun/emas/apm/crash/ndk/a$$ExternalSyntheticLambda0;-><init>(Lcom/aliyun/emas/apm/crash/ndk/a;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/ndk/a;->d:Lcom/aliyun/emas/apm/crash/ndk/a$a;

    iget-boolean p1, p0, Lcom/aliyun/emas/apm/crash/ndk/a;->b:Z

    if-eqz p1, :cond_0

    .line 11
    invoke-interface {v0}, Lcom/aliyun/emas/apm/crash/ndk/a$a;->a()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method
