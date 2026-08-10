.class final Lcom/aliyun/emas/apm/crash/internal/model/a$t;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/firebase/encoders/ObjectEncoder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "t"
.end annotation


# static fields
.field static final a:Lcom/aliyun/emas/apm/crash/internal/model/a$t;

.field private static final b:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final c:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final d:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final e:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final f:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final g:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final h:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final i:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final j:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final k:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final l:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final m:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final n:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final o:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final p:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final q:Lcom/google/firebase/encoders/FieldDescriptor;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/internal/model/a$t;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$t;

    const-string v0, "dalvikPrivateDirty"

    .line 3
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->b:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "dalvikPss"

    .line 5
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->c:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "dalvikSharedDirty"

    .line 7
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->d:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "nativePrivateDirty"

    .line 9
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->e:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "nativePss"

    .line 11
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->f:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "nativeSharedDirty"

    .line 13
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->g:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "otherPrivateDirty"

    .line 15
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->h:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "otherPss"

    .line 17
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->i:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "otherSharedDirty"

    .line 19
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->j:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "memoryStat"

    .line 21
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->k:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "totalSwappablePss"

    .line 23
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->l:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "totalSharedDirty"

    .line 25
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->m:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "totalSharedClean"

    .line 27
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->n:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "totalPss"

    .line 29
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->o:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "totalPrivateDirty"

    .line 31
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->p:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "totalPrivateClean"

    .line 33
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->q:Lcom/google/firebase/encoders/FieldDescriptor;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;Lcom/google/firebase/encoders/ObjectEncoderContext;)V
    .locals 2

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->b:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 1
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getDalvikPrivateDirty()I

    move-result v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;I)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->c:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 2
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getDalvikPss()I

    move-result v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;I)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->d:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 3
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getDalvikSharedDirty()I

    move-result v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;I)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->e:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getNativePrivateDirty()I

    move-result v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;I)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->f:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 5
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getNativePss()I

    move-result v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;I)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->g:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 6
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getNativeSharedDirty()I

    move-result v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;I)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->h:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 7
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getOtherPrivateDirty()I

    move-result v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;I)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->i:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 8
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getOtherPss()I

    move-result v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;I)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->j:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 9
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getOtherSharedDirty()I

    move-result v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;I)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->k:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 10
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getMemoryStat()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;Ljava/lang/Object;)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->l:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 11
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getTotalSwappablePss()I

    move-result v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;I)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->m:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 12
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getTotalSharedDirty()I

    move-result v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;I)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->n:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 13
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getTotalSharedClean()I

    move-result v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;I)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->o:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 14
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getTotalPss()I

    move-result v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;I)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->p:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 15
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getTotalPrivateDirty()I

    move-result v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;I)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->q:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 16
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getTotalPrivateClean()I

    move-result p1

    invoke-interface {p2, v0, p1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;I)Lcom/google/firebase/encoders/ObjectEncoderContext;

    return-void
.end method

.method public bridge synthetic encode(Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;

    check-cast p2, Lcom/google/firebase/encoders/ObjectEncoderContext;

    invoke-virtual {p0, p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;Lcom/google/firebase/encoders/ObjectEncoderContext;)V

    return-void
.end method
