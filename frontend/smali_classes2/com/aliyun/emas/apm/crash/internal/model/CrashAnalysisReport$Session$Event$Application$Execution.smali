.class public abstract Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Execution"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/o$b;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/internal/model/o$b;-><init>()V

    return-object v0
.end method


# virtual methods
.method public abstract getAppExitInfo()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;
.end method

.method public abstract getException()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;
.end method

.method public abstract getNdkPayload()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;
.end method

.method public abstract getThreads()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;",
            ">;"
        }
    .end annotation
.end method
