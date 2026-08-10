.class final Lcom/aliyun/emas/apm/crash/internal/model/o$b;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/o;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "b"
.end annotation


# instance fields
.field private a:Ljava/util/List;

.field private b:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

.field private c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

.field private d:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;-><init>()V

    return-void
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;
    .locals 7

    .line 1
    new-instance v6, Lcom/aliyun/emas/apm/crash/internal/model/o;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/o$b;->a:Ljava/util/List;

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/o$b;->b:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/internal/model/o$b;->c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    iget-object v4, p0, Lcom/aliyun/emas/apm/crash/internal/model/o$b;->d:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;

    const/4 v5, 0x0

    move-object v0, v6

    invoke-direct/range {v0 .. v5}, Lcom/aliyun/emas/apm/crash/internal/model/o;-><init>(Ljava/util/List;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;Lcom/aliyun/emas/apm/crash/internal/model/o$a;)V

    return-object v6
.end method

.method public setAppExitInfo(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/o$b;->c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    return-object p0
.end method

.method public setException(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/o$b;->b:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    return-object p0
.end method

.method public setNdkPayload(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/o$b;->d:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;

    return-object p0
.end method

.method public setThreads(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/o$b;->a:Ljava/util/List;

    return-object p0
.end method
