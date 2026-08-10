.class public final Lcom/aliyun/emas/apm/crash/n;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/n$b;
    }
.end annotation


# static fields
.field private static final c:Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;


# instance fields
.field private final a:Lcom/aliyun/emas/apm/inject/Deferred;

.field private final b:Ljava/util/concurrent/atomic/AtomicReference;


# direct methods
.method public static synthetic $r8$lambda$5EP2QCiOSacJUqpkUEa05DY-bh4(Lcom/aliyun/emas/apm/crash/n;Lcom/aliyun/emas/apm/inject/Provider;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/n;->a(Lcom/aliyun/emas/apm/inject/Provider;)V

    return-void
.end method

.method public static synthetic $r8$lambda$oWO-6wWhCQU7IWdbEF0dXIkVNFc(Ljava/lang/String;Lcom/aliyun/emas/apm/inject/Provider;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/aliyun/emas/apm/crash/n;->a(Ljava/lang/String;Lcom/aliyun/emas/apm/inject/Provider;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/n$b;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/aliyun/emas/apm/crash/n$b;-><init>(Lcom/aliyun/emas/apm/crash/n$a;)V

    sput-object v0, Lcom/aliyun/emas/apm/crash/n;->c:Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;

    return-void
.end method

.method public constructor <init>(Lcom/aliyun/emas/apm/inject/Deferred;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/concurrent/atomic/AtomicReference;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/n;->b:Ljava/util/concurrent/atomic/AtomicReference;

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/n;->a:Lcom/aliyun/emas/apm/inject/Deferred;

    .line 9
    new-instance v0, Lcom/aliyun/emas/apm/crash/n$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/aliyun/emas/apm/crash/n$$ExternalSyntheticLambda0;-><init>(Lcom/aliyun/emas/apm/crash/n;)V

    invoke-interface {p1, v0}, Lcom/aliyun/emas/apm/inject/Deferred;->whenAvailable(Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;)V

    return-void
.end method

.method private synthetic a(Lcom/aliyun/emas/apm/inject/Provider;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/n;->b:Ljava/util/concurrent/atomic/AtomicReference;

    .line 1
    invoke-interface {p1}, Lcom/aliyun/emas/apm/inject/Provider;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    return-void
.end method

.method private static synthetic a(Ljava/lang/String;Lcom/aliyun/emas/apm/inject/Provider;)V
    .locals 0

    .line 2
    invoke-interface {p1}, Lcom/aliyun/emas/apm/inject/Provider;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    .line 3
    invoke-interface {p1, p0}, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;->prepareNativeSession(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public getSessionFileProvider(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/n;->b:Ljava/util/concurrent/atomic/AtomicReference;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    if-nez v0, :cond_0

    sget-object p1, Lcom/aliyun/emas/apm/crash/n;->c:Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;

    goto :goto_0

    .line 4
    :cond_0
    invoke-interface {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;->getSessionFileProvider(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;

    move-result-object p1

    :goto_0
    return-object p1
.end method

.method public hasCrashDataForCurrentSession()Z
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/n;->b:Ljava/util/concurrent/atomic/AtomicReference;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    if-eqz v0, :cond_0

    .line 2
    invoke-interface {v0}, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;->hasCrashDataForCurrentSession()Z

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

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/n;->b:Ljava/util/concurrent/atomic/AtomicReference;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    if-eqz v0, :cond_0

    .line 2
    invoke-interface {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;->hasCrashDataForSession(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method

.method public prepareNativeSession(Ljava/lang/String;)V
    .locals 3

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Deferring native open session: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/n;->a:Lcom/aliyun/emas/apm/inject/Deferred;

    .line 3
    new-instance v1, Lcom/aliyun/emas/apm/crash/n$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lcom/aliyun/emas/apm/crash/n$$ExternalSyntheticLambda1;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Lcom/aliyun/emas/apm/inject/Deferred;->whenAvailable(Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;)V

    return-void
.end method
