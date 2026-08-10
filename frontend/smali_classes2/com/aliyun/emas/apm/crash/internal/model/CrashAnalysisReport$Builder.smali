.class public abstract Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
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
.method public abstract build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
.end method

.method public abstract setApp(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method

.method public abstract setClientTime(Ljava/lang/Long;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method

.method public abstract setDevice(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method

.method public abstract setEventId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method

.method public abstract setEventTime(Ljava/lang/Long;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method

.method public abstract setNetwork(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method

.method public abstract setPayload(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method

.method public abstract setPlatform(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method

.method public abstract setProtocolVersion(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method

.method public abstract setSampleRate(D)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method

.method public abstract setSdk(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method

.method public abstract setSessionId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method

.method public abstract setUser(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method

.method public abstract setUtdid(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method

.method public abstract setUuid(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method
