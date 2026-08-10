.class public abstract Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
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
.method public abstract build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
.end method

.method public abstract setApp(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
.end method

.method public abstract setDevice(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
.end method

.method public abstract setLogcat([B)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
.end method

.method public abstract setMemory(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
.end method

.method public abstract setRollouts(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
.end method

.method public abstract setTimestamp(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
.end method

.method public abstract setType(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;
.end method
