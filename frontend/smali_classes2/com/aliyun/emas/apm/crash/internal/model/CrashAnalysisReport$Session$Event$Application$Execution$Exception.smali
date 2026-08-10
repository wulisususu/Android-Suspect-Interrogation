.class public abstract Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Exception"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/p$b;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/internal/model/p$b;-><init>()V

    return-object v0
.end method


# virtual methods
.method public abstract getCausedBy()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;
.end method

.method public abstract getFrames()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;",
            ">;"
        }
    .end annotation
.end method

.method public abstract getOverflowCount()I
.end method

.method public abstract getReason()Ljava/lang/String;
.end method

.method public abstract getType()Ljava/lang/String;
.end method
