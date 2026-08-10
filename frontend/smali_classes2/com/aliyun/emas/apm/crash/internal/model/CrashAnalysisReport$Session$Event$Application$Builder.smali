.class public abstract Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Builder"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;
.end method

.method public abstract setAppProcessDetails(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;",
            ">;)",
            "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;"
        }
    .end annotation
.end method

.method public abstract setBackground(Ljava/lang/Boolean;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
.end method

.method public abstract setCurrentProcessDetails(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
.end method

.method public abstract setCustomAttributes(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;",
            ">;)",
            "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;"
        }
    .end annotation
.end method

.method public abstract setExecution(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
.end method

.method public abstract setInternalKeys(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;",
            ">;)",
            "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;"
        }
    .end annotation
.end method

.method public abstract setNetwork(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
.end method

.method public abstract setUiOrientation(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
.end method

.method public abstract setUser(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;
.end method
