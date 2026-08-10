.class public abstract Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation runtime Lcom/google/firebase/encoders/annotations/Encodable;
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Architecture;
    }
.end annotation


# static fields
.field private static final a:Ljava/nio/charset/Charset;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "UTF-8"

    .line 1
    invoke-static {v0}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->a:Ljava/nio/charset/Charset;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a()Ljava/nio/charset/Charset;
    .locals 1

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->a:Ljava/nio/charset/Charset;

    return-object v0
.end method

.method public static builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/b$b;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/internal/model/b$b;-><init>()V

    return-object v0
.end method


# virtual methods
.method protected abstract b()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
.end method

.method public abstract getApp()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;
.end method

.method public abstract getClientTime()Ljava/lang/Long;
.end method

.method public abstract getDevice()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;
.end method

.method public abstract getEventId()Ljava/lang/String;
.end method

.method public abstract getEventTime()Ljava/lang/Long;
.end method

.method public abstract getNetwork()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;
.end method

.method public abstract getPayload()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;
.end method

.method public abstract getPlatform()Ljava/lang/String;
.end method

.method public abstract getProtocolVersion()Ljava/lang/String;
.end method

.method public abstract getSampleRate()D
.end method

.method public abstract getSdk()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;
.end method

.method public abstract getSessionId()Ljava/lang/String;
.end method

.method public getType()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;
    .locals 1
    .annotation runtime Lcom/google/firebase/encoders/annotations/Encodable$Ignore;
    .end annotation

    .line 1
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;->b:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    return-object v0
.end method

.method public abstract getUser()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;
.end method

.method public abstract getUtdid()Ljava/lang/String;
.end method

.method public abstract getUuid()Ljava/lang/String;
.end method

.method public withEvents(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;",
            ">;)",
            "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;"
        }
    .end annotation

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getPayload()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 5
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->b()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getPayload()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->a(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setPayload(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p1

    return-object p1

    .line 6
    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "Reports without sessions cannot have events added to them."

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public withLog(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
    .locals 3

    .line 1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-object p0

    .line 5
    :cond_0
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->b()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getPayload()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object v1

    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log$Builder;

    move-result-object v2

    invoke-virtual {v2, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log$Builder;->setContent(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    move-result-object p1

    invoke-virtual {v1, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setPayload(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p1

    return-object p1
.end method

.method public withNetwork(Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
    .locals 2

    .line 1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-object p0

    .line 5
    :cond_0
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->b()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;->setCarrier(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;->setAccess(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setNetwork(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p1

    return-object p1
.end method

.method public withSessionEndFields(JZ)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
    .locals 2

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->b()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    .line 2
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getPayload()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 3
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getPayload()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object v1

    invoke-virtual {v1, p1, p2, p3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->a(JZ)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setPayload(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    .line 5
    :cond_0
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p1

    return-object p1
.end method

.method public withTime(JJ)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
    .locals 1

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->b()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setEventTime(Ljava/lang/Long;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object p1

    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setClientTime(Ljava/lang/Long;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p1

    return-object p1
.end method

.method public withUser(Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
    .locals 2

    .line 1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-object p0

    .line 5
    :cond_0
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->b()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;->setId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;->setNick(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setUser(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p1

    return-object p1
.end method
